	.data
	.align 0
str1:	.asciz "Insira uma string: "
str2:	.asciz "String invertida: "
buffer:	.space 100 #espaço reservado para a string

	.text
	.align 2
	.globl main
main:
	la a0,str1
	addi a7,zero,4
	ecall #printa str1
	
	la a0,buffer
	addi a1,zero,100
	addi a7,zero,8 #serviço para ler str do usuario
	ecall #pega input do usuario
	
	jal str_len
	
	add a0,zero,a1 #a0 é parametro e recebe o tamanho da string inputada
	jal inverte
	
	la a0, str2
	addi a7,zero,4
	ecall
	jal print_string
	jal fim_programa
inverte:
	la t0,buffer
	add t2,t0,a0  #t2 aponta para o fim+1
	addi t2,t2,-1 #arrumar pro final
inverte_loop:
	bge t0,t2,fim_inverte #os ponteiros se cruzaram
	lb t3,0(t0)
	lb t4,0(t2)
	sb t3,0(t2)
	sb t4,0(t0)
	addi t0,t0,1
	addi t2,t2,-1
	j inverte_loop
fim_inverte:
	jr ra
str_len:
	addi a1,zero,0
str_len_loop:

	lb t0, 0(a0) #carrega em t0 o valor do primeiro byte apontado por s0
	beq t0,zero,str_len_fim
	addi a1,a1,1 #incrementando o valor de retorno
	addi a0,a0,1	#incrementa o ponteiro
	j str_len_loop
	
str_len_fim:
	jr ra #volta pra onde chamou
	
print_string:
	la a0,buffer
	addi a7,zero,4
	ecall #printa string
fim_programa:
	addi a7,zero,10
	ecall	