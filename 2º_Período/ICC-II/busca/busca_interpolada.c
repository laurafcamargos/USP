#include <stdio.h>
#include <stdlib.h>

int busca_binaria(int a[], int n, int x)
{ //O(log log n)
    int c = 0;
    int f = n - 1;
    while (c <= f)
    {
        if (a[f] == a[c])
        {
            if (a[c] == x)
            {
                return c;
            }else return -1; 
        }
        
       /*A = (x - a[c]) //a distância do valor do elemento procurado até o valor do primeiro elemento
         B = (a[f] - a[c]) //a distância do último elemento do primeiro                            
         C = ( m - c) //a distância da posição do x até a posição do primeiro
         D = (f  -  c) //a distância da posição do último até o primeiro
         A / B = C / D //regra de 3 */ 
        int m = c + (x - a[c]) * (f - c) / (a[f] - a[c]);
        if (x == a[m])
            return m;
        else if (x < a[m])
        {
            f = m - 1;
        }
        else
        { // x > a[m]
            c = m + 1;
        }
    }
}
