	.data
	.align 0
str_1:	.asciz "essa eh a string um!"
str_2:	.asciz " essa eh a string 2!"
strcat: .space 120
 

	.text
	.align 2
	.globl main
main:	


		#EM TESE PRECISA ALOCAR O ESPAÇO PRA SOMA DOS TAMANHOS!!!!
		#MAS NO RARS ELAS SAO GUARDADAS SEQUENCIAIS ENTAO EU TENHO CTZ DO TAMANHO!!!
		##TBM POSSO FAZER UM BUFFER DE 200 E COLOCAR NO MAX 100 NAS DUAS ECALLS DE LEITURA!!! ASSIM GARANTE!!

		#PERCORRER STRING ATE O FIM
		#carrega o endereco da string de entrada
		la s0, str_1
		la s2, strcat
		
		#le conteudo da str_1
copy:		lb t1, 0(s0)
		
		# faz ate encontrar /0
		beq t1, zero, sai_copy
		
		#copia pra strcat
		sb t1, 0(s2)

		#incrementa os ponteiros
		addi s0, s0, 1
		addi s2, s2, 1
		
		j copy
	
sai_copy:	la s1, str_2


conct:		lb t1, 0(s1)
		sb t1, 0(s2)
		
		addi s2, s2, 1
		addi s1, s1, 1

		beq t1, zero, sai_conct

		
		j conct
		
sai_conct:	la a0, strcat
		#chamada para escrever string
		addi a7, zero, 4
		ecall
		
		#finaliza o programa
		addi a7, zero, 10
		ecall				
