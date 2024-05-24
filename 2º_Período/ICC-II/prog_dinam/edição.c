#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int min(int x, int y)
{
    if (x < y)
    {
        return x;
    }
    else
    {
        return y;
    }
}
int de_aux(int **cache, char *p1, int i1, int l1, char *p2, int i2, int l2)
{
    if (cache[i1][i2] == -1)
    {
        int res;

        if (i1 >= l1)
        { // final da primeira palavra
            return l2 - i2;
        }
        else if (i2 >= l2)
        {
            return l1 - i1;
        }
        else
        {
            if (p1[i1] == p2[i2])
            {
                return de_aux(p1, i1 + 1, l1, p2, i2 + 1, l2);
            }
            else
            {
                int mudar = 1 + de_aux(p1, i1 + 1, l1, p2, i2 + 1, l2);
                int remover = 1 + de_aux(p1, i1 + 1, l1, p2, i2, l2);
                int adicionar = 1 + de_aux(p1, i1, l1, p2, i2 + 1, l2);
                return min(mudar, min(remover, adicionar));
            }
        }
        cache[i1][i2] = res;
    }
    return cache[i1][i2];
}

int main(int argc, char *argv[])
{
    char *p1 = argv[1];
    char *p2 = argv[2];
    int l1 = strlen(p1);
    int l2 = strlen(p2);

    int res = de(p1, 0, l1, p2, 0, l2);

    printf("de('%s', '%s') = %d\n", p1, p2, res);
}