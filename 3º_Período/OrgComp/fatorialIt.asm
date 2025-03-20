	.data
	.align 0
str1: 	.asciz "Digite um número inteiro:"
str2: 	.asciz "O fatorial do número digitado é:"
	.text
	.align 2
	.globl main
main:
	la a0,str1
	addi a7,zero,4 #printar string
	ecall
	
	addi a7,zero,5 #lê inteiro do usuário e coloca no a0, soma zero + 5 no reg a07
	ecall
	
	addi t1,zero,1 #vai armazenar o resultado do fatorial
	add t0,a0,zero #copia o conteúdo que estava em a0 para t0 (temp)

	la a0,str2
	addi a7,zero,4 #printar string
	ecall
	
	addi t2,zero,1 #contador do nosso loop(i)
	j fat
 
fat:
    	mul t1, t1, t2     # (t1 = t1 * t2)
    	addi t2, t2, 1     # i++ 
    	ble t2, t0, fat    #t2<= t0 repete, até chegar no numero inputado

    	addi a7, zero, 1
    	add a0, zero, t1
    	ecall

    	li a7, 10
    	ecall
	

	
