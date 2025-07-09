	.data	
	.align 0	
	
str1:	.asciz "Vetor desordenado: "
str2:	.asciz "\nVetor ordenado: "
	.align 2
vetor:	.word 7,5,2,1,1,3,4
	.text
	.globl main

main:
	addi s0, zero ,7 #tamanho do vetor é 7
	addi a7, zero,4 #serviço para printar string
	la a0, str1
	ecall #printa str1
	
	addi a7, zero, 1 #serviço para print int
	addi t0, zero,0 #contador = 0 
	la t1, vetor #carrega o endereço de memória do primeiro byte do vetor para t1
print_loop:
	beq t0,s0,bubble_sort #se for igual significa que já printou todos os elementos
	lw a0, 0(t1) #carrega o inteiro que está na posição apontada por t1 para o reg a0
	ecall #printa
	addi t0,t0,1 # contador++
	addi t1,t1,4 #incrementa o endereço do vetor
	j print_loop # fica até printar o vetor inteiro
bubble_sort:
	addi t0, zero,0 #t0: i = 0
for_externo: 
	beq t0,s0,fim_for_externo #para i de 0 até MAX-1 faça
	addi t1, s0,-1 #t1: j = 6 (começa de tras pra frente)
	la t2, vetor #t2: ponteiro que aponta para o endereço de memória do primeiro byte do vetor
	addi t2,t2,24 #o ponteiro passa a apontar para o último bytes de inteiro do vetor
for_interno:
	beq t1,t0,fim_for_interno #se j == i, sai do for
	lw t3,0(t2)#t3: inteiro que está sendo apontado por t2 [j]
	lw t4,-4(t2) #t4: penúltimo, [j-1]
	
	bgt t4,t3, troca #se o [j-1] > [j] troca eles de lugar
	j fim_troca
troca:
	sw t3,-4(t2) #escreve o conteúdo de t3 na posição apontada por t2 -4
	sw t4,0(t2) #escreve o conteúdo de t4 na posição apontada por t2 
fim_troca:
	addi t2,t2,-4 #anda na posição do vetor pra tras
	addi t1,t1,-1 #j --
	j for_interno
fim_for_interno:
	addi t0,t0,1 #i++
	j for_externo #terminou o de dentro, vai pro de fora
	
fim_for_externo:
	addi a7, zero, 4#serviço que printa string
	la a0, str2
	ecall #printa str2
	
	addi a7,zero,1
	addi t0, zero,0
	la t1,vetor
print_ordenado:
	beq t0,s0,fim_programa #se for igual significa que já pode sair
	lw a0, 0(t1) #carrega o inteiro que está na posição apontada por t1 para o reg a0
	ecall #printa
	addi t0,t0,1 # contador++
	addi t1,t1,4 #incrementa o endereço do vetor
	j print_ordenado # fica até printar o vetor inteiro
fim_programa:
	addi a7,zero,10
	ecall