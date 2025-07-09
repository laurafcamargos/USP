# Fatorial com função

    	.data
    	.align 0
str1:   .asciz "Digite um numero de 0 a 12: "
str2:   .asciz "O fatorial de "
str3:   .asciz " eh " 
    	.text
    	.align 2
    	.globl main
main:
    	addi a7, zero, 4       # serviço para imprimir string
    	la a0, str1 
    	ecall                  # exibe str1

    	addi a7, zero, 5       # lê inteiro (a0)
    	ecall

    	add s0, zero, a0       # salva o valor lido em s0
    	jal fat                # chama a função fatorial
    	add s1, zero, a1       # salva o resultado em s1

    	addi a7, zero, 4       # exibe str2
    	la a0, str2 
    	ecall

    	addi a7, zero, 1       # exibe o número original (s0)
    	add a0, zero, s0 
    	ecall

    	addi a7, zero, 4       # exibe str3
    	la a0, str3 
    	ecall

    	addi a7, zero, 1       # exibe o resultado (s1)
    	add a0, zero, s1 
    	ecall

    	addi a7, zero, 10      # encerra o programa
    	ecall

fat:
    	addi a1, zero, 1       # inicializa resultado com 1
loop:
    	mul a1, a1, a0        # a1 = a1 * a0
    	addi a0, a0, -1       # decrementa a0
    	addi t0, zero, 1      # t0 = 1 para comparação
    	blt t0, a0, loop      # se a0 > 1, continua o loop
    	jr ra                 # retorna com a1 = a0!, pra depois do jal