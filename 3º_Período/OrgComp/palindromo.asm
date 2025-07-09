# Palíndromo
	
	.data
	.align 0
str1:	.asciz "É palindromo?\n"
str2:	.asciz "aabb"
yes:    .asciz "\nÉ palindromo"
no:     .asciz "\nNão é palindromo"
	.text
	.align 2
	.globl main

main:
	addi a7, zero, 4 #serviço para printar string
	la a0,str1 #a0 = recebe endereço do primeiro byte da str1
	ecall #printa string
	
	la a0, str2 #a0 = recebe endereço do primeiro byte da str2
	jal str_len # função que calcula tamanho da string
	
	
	add a0,zero,a1 #o retorno (a1) da str_len vira parâmetro da função palindromo (a0)
	la s0,str2 #salva em s0 o end do primeiro byte de str2(palavra em questão)
	jal palindromo #vamos pra função palindromo
	
	addi a7, zero, 4 #serviço para printar string
	la a0,str2 #a0 = recebe endereço do primeiro byte da str2
	ecall
	
	beqz a1, printa_nao #se for 0 não eh palindromo (a1 é o nosso retorno da função)
	la a0, yes #a0 = recebe endereço do primeiro byte da string que printa que é palindromo
	j print_resultado #vamos printar isso

printa_nao:
    la a0, no #a0 = recebe endereço do primeiro byte da string que printa que não é palindromo
    
print_resultado:
	ecall #o que precisa ser printado já está em a0, vê lá
	addi a7,zero,10
	ecall #sai do programa

str_len:
	addi a1,zero,0 #nosso contador, que será o retorno da nossa função
str_len_loop:

	lb t0, 0(a0) #carrega em t0 o valor do primeiro byte apontado por s0
	beq t0,zero,str_len_fim #fica até achar o /0
	addi a1,a1,1 #incrementando o valor de retorno
	addi a0,a0,1	#incrementa o ponteiro
	j str_len_loop 
	
str_len_fim:
	jr ra #volta pra onde chamou

palindromo:

	add t0,zero,s0 #t0 recebe endereço da str2

	add t1,zero,t0 #t1 = ponteiro pro início
	add t2,t0,a0 #t2 = fim +1
	addi t2,t2,-1 # arruma ponteiro pro último endereço
	
	addi a1,zero,1 #a1 = 1
	
compara:	
	bge t1,t2,passou_palindromo #os ponteiros se cruzaram
	lb t3,0(t1) #carrega o char inicial pro t3
	lb t4,0(t2) #carrega o char final pro t4
	bne t3, t4, nao_eh_palindromo
	addi t1,t1,1 #avança com o ponteiro
	addi t2,t2,-1 #recua com o ponteiro
	j compara #faz isso até os ponteiros se cruzarem
	
nao_eh_palindromo:
	addi a1,zero,0 #nao eh palindromo, então a1 retorna com 0
	
passou_palindromo:
	jr ra #volta pra onde foi chamado, ou seja, na main
	
	
	