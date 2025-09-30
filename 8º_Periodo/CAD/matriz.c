#pragma omp parallel for default (private) shared (a, b, c, dim) \
num_threads (2)
for (i = 0; i < dim; i++) {
    
    #pragma omp parallel for default (private) shared (a, b, c, dim) \
    num_threads (2)
    for (j=0; j < dim; j++) {
        c(i,j) = 0;
        
        #pragma omp parallel for default (private) \
        shared (a, b, c, dim) num_threads (2)
        for (k = 0; k < dim; k++) {
            c(i,j) += a(i, k) * b(k, j);
        }
    }
}   


//O que esse algoritmo faz? Multiplicação de matrizes
//esse alg tá errado? sim - a matriz c é região crítica e não está protegida na condição de disputa da linha 11
//Pode-se melhorar o código usando operação de redução na linha 11 (não entendi direito como...)
//Quantas threads rodam nesse código? A grosso modo, 8 threads estão fazendo trabalho. Entretanto, o número real de threads rodando depende da implementação e não é explícito no openmp