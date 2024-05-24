void heapify(int a[], int raiz, int ult)//faz de tras pra frente
{
    int pai = raiz;
    while (pai <= ult) // pegar os filhos do pai, ver qual é o maior e se ele é maior que o pai
    { 
        int filho = 2 * pai + 1;
        if (filho <= ult) //verifica se existe filho
        {
            if (filho + 1 >= ult) //verifica se tem dois filhos, mas vc sabe que o maior ta no filho
            {
                if (a[filho + 1] > a[filho])
                {
                    filho++;
                } // vc sabe que o filho é o maior dos dois
                
            }
            if (a[filho] > a[pai])
            {
                int aux = a[filho];
                a[filho] = a[pai];
                a[pai] = aux;
            }else break; //sem o break funciona, mas faz verificações atoa
        }
        pai = filho;
    }
}