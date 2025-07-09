#mais bonitinho
#
	.data
	.align 0
str1:	.asciz "Digite um numero de 0 a 12: "
str2:	.asciz "O fatorial de "
str3:	.asciz " eh "	
	.text
	.align 2
	.globl main

main:

	
	addi a7, zero,4
 	la a0,str1
	ecall

	li a7,5
	ecall

	add s0,zero,a0 #salva valor do usuário no s0
	#valor de retorno do fatorial 
	addi s1, zero, 1
	add t0, zero,s0 	#t0 = contador
	
loop:	
	beq t0,zero,fim
	mul s1,s1,t0
	addi t0,t0,-1
	j loop

fim:	
	addi a7, zero,4
 	la a0,str2
	ecall

	addi a7, zero, 1
	add a0, zero, s0
	ecall#imprimimos o numero do usuario

	addi a7, zero,4
 	la a0,str3
	ecall #imprimimoso "eh"

	addi a7, zero, 1
	add a0, zero, s1
	ecall

	li a7,10
	ecall