#variavel na memoria que é ponteiro: armazenar um endereço, senão fere o conceito de ponteiro	
	.data
	.align 0
str_src: .asciz "Oi mae!"
   	.align 2
p:	.word #variavel ponteiro(armazena end de 4 bytes)

	.text
	.align 0
	.globl main
main:	#calcula o tamanho da string
	#t1: contador
	#do-while, enquanto o caracter for diferente de 0
	li t1, 0
	#s0 = endereço
	la s0, str_src #endereço
	#t0: char lido
	
loop_tam: #calcular tamanho da string
	lb t0,0(s0)
	#avançar o endereço na string
	addi s0,s0,1
	#incrementar o contador
	addi t1, t1,1 
	#verifica condição de continuar no loop
	bne t0,zero,loop_tam

	#alocar espaço na heap
	li a7,9 #sbrk
	#copia o tamanho da string p reg a0
	add a0, zero,t1
	ecall #aloca o tamanho q tem em a0 bytes para a str_src
	#armazenar o conteúdo de a0 na posição de memoria referenciada por p
	#t2 = endereço do primeiro byte apontado por p
	la t2, p
	#armazenar a0 na posição apontada por t2
	sw a0,0(t2) #importante! esse é o conceito de ponteiro
	
	#preparaçao para a copia de fato
	#s0: endereço da str_src
	la s0,str_src
	#s1: endereço da str_dst
	la t2, p #carregou pra t2 o endereço de p
	lw s1,0(t2) #carregando o endereço apontado por p em s1

loop_cpy:
	lb t0,0(s0)
	sb t0,0(s1)
	addi s0,s0,1
	addi s1,s1,1
	bne t0,zero,loop_cpy
	#impressão da string copiada
	li a7,4 #imprime
	la t2, p
	lw a0,0(t2) #coloca em a0 o conteúdo da posição de t2
	ecall
	li a7,10
	ecall
