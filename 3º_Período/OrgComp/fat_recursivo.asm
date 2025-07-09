	.data
	.align 0
str_entrada: .asciz "Digite um número: "
str_saida: .asciz "Fatorial calculado: "
	.text
	.align 2
	.globl main

main:	#imprime msg
	li a7, 4
	la a0, str_entrada
	ecall
	
	#lê inteiro
	li a7, 5
	ecall
	
	#salva o nro digitado
	add s0, zero, a0
	
	#chama função
	jal fatorial
	
	#salva valor do fatorial calculado em s1
	add s1, zero, a1
	
	#imprime a str de saida
	li a7, 4
	la a0, str_saida
	ecall
	
	#imprime o fatorial calculado
	li a7, 1
	add a0, zero, s1
	ecall
	
	#encerra
	li a7, 10
	ecall
	
	#função fatorial
	#a0: nro a ser calculado
	#a1: fatorial calculado

fatorial:
	#empilhar ra e a0
	addi sp, sp, -8
	sw a0, 4(sp)
	sw ra, 0(sp)
	
	#compara condição de parada
	beq a0, zero, retorna_1
	
	#decrementa parâmetro
	addi a0, a0, -1
	
	#chama função recursiva
	jal fatorial
	
	#incrementar a0
	addi a0, a0, 1
	mul a1, a1, a0
	j sai_fat
	
retorna_1:

	addi a1, zero, 1
	
sai_fat:
	#desempilhar ra e a0
	lw a0, 4(sp)
	lw ra, 0(sp)
	
	addi sp, sp, 8
	
	jr ra
	