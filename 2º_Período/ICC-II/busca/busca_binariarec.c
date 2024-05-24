#include <stdio.h>
#include <stdlib.h>
int busca_recursiva(int a[], int c, int f, int x);


int busca_recursiva(int a[], int c, int f, int x)
{ //O(log n)
    if (c > f)
    {
        return -1;
    }
       int m = (c + f) / 2;
        if (x == a[m])
            return m;
        else if (x < a[m])
        {
            return busca_recursiva(a,c, m - 1,x);
        }
        else
        { // x > a[m]
            return busca_recursiva(a, m+1, f,x);
        }
}

