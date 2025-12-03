#include <stdio.h>
#include <mpi.h>
#include <omp.h>

#define NT 4 // numero de threads

int main(int argc, char *argv[])
{
	int numprocs, rank, namelen;
	char processor_name[MPI_MAX_PROCESSOR_NAME];
	int iam = 0, np = 1, provided;

	//  MPI_Init(&argc, &argv);
	MPI_Init_thread(&argc, &argv, MPI_THREAD_SINGLE /*MPI_THREAD_SINGLE*/, &provided);

	// mesmo que MPI_Init(). Somente uma thread executará
	if (provided == MPI_THREAD_SINGLE)
	{
		printf("MPI_THREAD_SINGLE\n");
		fflush(0);
	}

	// se multithreaded, so processo que chamou MPI_Init_thread
	// faz chamadas MPI
	if (provided == MPI_THREAD_FUNNELED)
	{
		printf("MPI_THREAD_FUNNELED\n");
		fflush(0);
	}

	// se multithreaded, so uma thread faz chamadas MPI por vez.
	if (provided == MPI_THREAD_SERIALIZED)
	{
		printf("MPI_THREAD_SERIALIZED\n");
		fflush(0);
	}

	// se multithreaded, multiplas threads podem
	// fazer chamadas MPI por vez sem restricoes.
	if (provided == MPI_THREAD_MULTIPLE)
	{
		printf("MPI_THREAD_MULTIPLE\n");
		fflush(0);
	}

	MPI_Comm_size(MPI_COMM_WORLD, &numprocs); //3
	MPI_Comm_rank(MPI_COMM_WORLD, &rank); //0 ou 1 ou 2
	MPI_Get_processor_name(processor_name, &namelen);

	#pragma omp parallel default(shared) private(iam, np) num_threads(NT)
	{
		np = omp_get_num_threads();
		iam = omp_get_thread_num();
		printf("Hello from thread %d/%d, from process %d/%d on %s\n", iam, np, rank, numprocs, processor_name);
	} // end of parallel region
	MPI_Finalize();
}  //printf executa 12x - 3 processos com 4 threads