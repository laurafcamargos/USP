
	
	# Secao de Dados
	.data					
	.align 0
	
	# Strings para auxiliar no visual do programa.
promptA: .asciz "Insira o id: "
promptB: .asciz "Insira a string (ate 26 caracteres): "
promptC: .asciz "Insira a quantidade de nos: "
espaco:  .asciz " "

	.align 2
	
	# Ponteiro para o primeiro no da lista
ponteiro: .word

	# Secao de codigo
	.text			
	.align 2					# Instrucoes de 32 bits
	.globl main
		
	# Legenda de Registradores:
	#
	# a0 - Parametro/Retorno do ecall
	# a1 - Parametro do Syscall ReadString
	# a2 - Endereco do ultimo no da lista
	# a3 - Endereco do no alocado pela funcao alocar_no
	# a7 - Parametro do ecall
	#
	# s0 - Tamanho de um no (36 bytes)
	# s1 - Tamanho atual da lista (altera-se ao longo do programa)
	# s2 - Quantidade total de nos da lista (constante ao longo do programa)
	# s10 - Valor -1 (NULL) usado para ponteiros nulos.
	
	# Estrutura do No:
	#
	# byte    : Conteudo
	# 0 - 3   : ID
	# 4 - 31  : String com 28 bytes
	# 32 - 35 : Ponteiro para o proximo no (prox)
		
main:
	
	# Inicializando variaveis:
	addi s0, zero, 36
	addi s1, zero, 0
	addi a1, zero, 28	
	addi s10, zero, -1
	
	# Lendo o tamanho da lista (quantidade total de nos)
	la a0, promptC
	jal print_string
	
	addi a7, zero, 5
	ecall
	
	# Salvando a quantidade total de nos
	add s2, zero, a0
	
	# Salvando o endereco de retorno
	addi sp, sp, -4
	sw ra, 0(sp)
	
	jal lista_criar
	
	
lista_criar:
	# Funcao que cria a lista. Quando a quantidade de nos (s1)
	# for igual a quantidade total de nos pedida pelo usuario (s2)
	# o loop se encerra e o programa pula para a funcao lista_printar.
	
	beq s1, s2, lista_printar
	jal criar_no
	j lista_criar

lista_printar:
	# Funcao que printa a lista, encerrando o programa no final.
	
	# Carregando o endereco do ponteiro (dado estatico) no registrador t1.
	la t1, ponteiro
	
	# Carregando o conteudo do ponteiro (endereco do primeiro no da lista)
	# em t0.
	lw t0, 0(t1)
	
printar:
	# Loop que printa cada no diminuindo o tamanho da lista (s1), quando
	# o tamanho for 0, encerramos o programa.
	
	beq s1, zero, sair_programa
	
	# Printando o ID
	addi a7, zero, 1
	lw a0, 0(t0)
	ecall
	
	# Printando um espaco (" ")
	la a0, espaco
	jal print_string
	
	# Printando a string
	
	# Colocando o endereco do no (t0) em a0 (parametro do ecall)
	add a0, zero, t0
	# Movendo o endereco ateh a secao do no com a string
	addi a0, a0, 4
	jal print_string
	
	# Carregando em t0 o endereco do proximo no
	lw t0, 32(t0)
	addi s1, s1, -1
	
	j printar
	
criar_no:
	# Funcao que cria um no, alocando a memoria na heap,
	# preenchendo seu conteudo e inserindo-o na lista.
	
	# Salvando o endereco de retorno
	addi sp, sp, -4
	sw ra, 0(sp)
	
	jal alocar_no
	
	jal preencher_no
	
	jal inserir_no

	# Recuperando o endereco de retorno
	lw ra, 0(sp)
	addi sp, sp, 4

	jr ra
	
alocar_no:	
	# Aloca a memoria de um novo no, fazendo seu ponteiro apontar
	# para NULL (-1)
	
	# Alocacao de memoria
	add a0, zero, s0
	addi a7, zero, 9
	ecall
	
	# Salvando em a3 o endereco do no recem alocado
	add a3, zero, a0
	
	# Fazendo ponteiro do proximo apontar pra NULL
	sw s10, 32(a3)
	 
	jr ra 
	
	
print_string:
	# FUncao que printa a string com endereco em a0.
	
	addi a7, zero, 4
	ecall
	
	jr ra	
	
preencher_no:
	# Funcao que preenche o conteudo do no em a3.
	
	# Salvando o endereco de retorno
	addi sp, sp, -4
	sw ra, 0(sp)
	
	# Printando o promptA
	la a0, promptA
	jal print_string
	
	# Lendo o ID
	addi a7, zero, 5
	ecall
	
	# Armazenando o ID
	sw a0, 0(a3)
	
	# Printando promptB
	la a0, promptB
	jal print_string
	
	# Lendo a string (28 chars)
	addi a7, zero, 8
	add a0, zero, a3
	addi a0, a0, 4
	ecall
	
	# Recuperando o endereco de retorno
	lw ra, 0(sp)
	addi sp, sp, 4
	
	jr ra
	
inserir_no:
	# Funcao que insere o no na lista
	
	# Se o tamanho atual da lista for 0, estamos inserindo
	# o primeiro no
	beq s1, zero, PRIMEIRO_NO
	
	# Salvando no prox do ultimo no da lista o endereco do
	# no recem alocado (a3)
	sw a3, 32(a2)
	
	# Incrementando o tamanho atual da lista
	addi s1, s1, 1
	
	# Salvando em a2 (ultimo no da lista) o endereco
	# do no recem alocado (a3) 
	add a2, zero, a3
	
	jr ra

PRIMEIRO_NO:
	# Carregando o endereco o ponteiro em t0
	la t0, ponteiro
	
	# Salvando no ponteiro o endereco do no alocado
	sw a3, 0(t0)
	
	# Incrementando o tamanho atual da lista
	addi s1, s1, 1
	
	# Salvando em a2 (ultimo no da lista) o endereco
	# do no recem alocado (a3) 
	add a2, zero, a3
	
	jr ra
	
sair_programa:
	addi a7, zero, 10
	ecall
