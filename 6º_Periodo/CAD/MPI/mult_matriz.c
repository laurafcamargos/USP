// to compile: mpicc mm.c -o mm -lm -fopenmp
// to run: mpirun -np order*order mm <matrix order>
//


#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <mpi.h>
#include <omp.h>

int main(int argc, char **argv)   
{
    int     my_rank, num_proc, root, tag;
    int		order, i, j, k, cij_result, *c;
    int 	*row_array, *column_array, count;
    
    MPI_Status 	status;
        
    if (argc != 2) 
	{
		printf("Wrong number of arguments. Please try again with mpirun -np order*order mm <order> \n");
        fflush(0);
		exit(0);
    }//end-if

    // order of our square matrices (A, B and C)
    // this is not necessary indeed, but exemplify how to use argc/argv in a MPI main program.
    order = atoi(argv[1]);
   
    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
    MPI_Comm_size(MPI_COMM_WORLD, &num_proc);

    // checking...
    if (sqrt(num_proc) != order)  
	{
		printf("Ops... something is wrong! Number of processes must be order^2! Pay attention and try again!\n");
		fflush(0);
		MPI_Finalize();
		exit(0);
    }//end-if

    // used by each Cij process to multiply (operations done by the n processes under each Cij process)
    row_array = (int *) calloc(order, sizeof(int));
    column_array = (int *) calloc(order, sizeof(int));

    // process with rank 0 is the responsible for creating and filling up matrices A and B
    // it also broadcasts the respective rows and columns for Cij processes
    if (my_rank == 0) 
	{
		int  *a, *b, aux, dest;
	
		// creating matrices
		a = (int *) calloc(num_proc, sizeof(int));
		b = (int *) calloc(num_proc, sizeof(int));
		c = (int *) calloc(num_proc, sizeof(int));

		// filling up them
		k = 0;
		for(i = 0; i < order; i++) 
		{
			for(j=0; j < order; j++)  
			{
				a[i*order+j] = b[i*order+j] = k++;
				// row_array and column_array are filled up here because they are used during the multiplication
				// other processes used them, then they will be used in the process 0 as well.
				if (i == 0)
				{
					row_array[j] = (k-1);
					if (j == 0)
					{
						column_array[i] = (k-1);
						//printf("a[%d][%d]= %d x b[%d][%d]=%d \n", i, j, a[i*order+j], i, j, b[i*order+j]);
						//fflush(0);
					} //if (j == 0)
				} // if (i == 0)
		  } // end-for-j
		}// end-for-i

		// transpose matrix for b. Used to send columns of b as rows.
		for(i = 0; i < (order-1); i++) 
		{
			for(j=i; j < (order-1); j++)  
			{
				aux = b[i*order+(j+1)];
				b[i*order+(j+1)] = b[(j+1)*order+i];
				b[(j+1)*order+i] = aux;
			} // end-for-j
		}// end-for-i

		/*
		for(i = 0; i < order; i++) 
		{
			for(j=0; j < order; j++)  
			{
				printf("b[%d][%d]=%d \n", i, j, b[i*order+j]);
				fflush(0);
			} // end-for-j
		}// end-for-i  
		*/

		//send rows of A and columns of B for other processes
		for(i = 0; i < order; i++) 
		{
			for(j=0; j < order; j++)  
			{
				dest = (i * order + j);
				tag = i;
				MPI_Send(&a[order*i], order, MPI_INT, dest, tag, MPI_COMM_WORLD);
				tag = j;
				MPI_Send(&b[order*j], order, MPI_INT, dest, tag, MPI_COMM_WORLD);
			} // end-for-j
		}// end-for-i
	}// end-if
    else 
	{ // Cij processes with rank != 0
		int src;
	
		src = 0;
		tag = (my_rank / order);
		MPI_Recv(row_array, order, MPI_INT, src, tag, MPI_COMM_WORLD, &status);
	
		tag = (my_rank % order);
		MPI_Recv(column_array, order, MPI_INT, src, tag, MPI_COMM_WORLD, &status);

		/*
		for(i = 0; i < order; i++) 
		{
			printf("my_rank = %d, row_array[%d]=%d,  column[%d]=%d \n", my_rank, i, row_array[i], i, column_array[i]);
			fflush(0);
		}// end-for-i  */
	
	} // end-else
  
    // now all processes, including rank 0, are executing this code.

    cij_result = 0;
    #pragma omp parallel for num_threads(16) schedule(dynamic, 4) private(k) reduction (+: cij_result) 
    for(k= 0; k < order; k++) 
	{
		cij_result += row_array[k] * column_array[k];
    } // end for
	
    // Process with my_rank == 0 receives all the c_ij already evaluated in their Cij respective positions.
    count = 1;
    root = 0;
    MPI_Gather(&cij_result, count, MPI_INT, c, count, MPI_INT, root, MPI_COMM_WORLD);

    // just process with rank 0, in MPI_COMM_WORLD will print the resulting C matrix
    if(my_rank == 0) 
	{
		for(i = 0; i < order; i++) 
		{
			for(j=0; j < order; j++)  
			{
				printf("c[%d][%d]= %d \n", i, j, c[i*order+j]);
				fflush(0);
			}//end-for-j
		}//end-for-i
    }// end-if

    MPI_Finalize();
    exit(0);
}// end-main