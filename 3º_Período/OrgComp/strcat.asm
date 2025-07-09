.data
    .align 0
str1:   .asciz "esse codigo "     # String 1
str2:   .asciz "concatena strings\n" # String 2
    .text
    .align 2
    .globl main
    
main:
    # Descobrir o tamanho da string 1
    la s0, str1           # s0 recebe endereço de str1
    addi a0, zero, 0      # contador = 0
    
loop_tamanho:
    lb t0, 0(s0)          # lendo o byte
    beq t0, zero, fim_tamanho  # se for \0, termina
    addi a0, a0, 1        # contador ++
    addi s0, s0, 1        # próximo byte
    j loop_tamanho
    
fim_tamanho:
    add s1, a0, zero      # salva tamanho de str1 em s1
    
    # Descobrir o tamanho da string 2
    la s0, str2           # agora aponta para str2
    addi a0, zero, 0      # contador = 0
    
loop_tamanho2:
    lb t0, 0(s0)          # lendo o byte
    beq t0, zero, fim_tamanho2  # se for \0, termina
    addi a0, a0, 1        # contador ++
    addi s0, s0, 1        # próximo byte
    j loop_tamanho2
    
fim_tamanho2:
    add s2, a0, zero      # salva tamanho de str2 em s2
    
    # Alocar espaço para a string concatenada
    add a0, s1, s2        # tamanho total = s1 + s2
    addi a0, a0, 1        # +1 para o null terminator
    addi a7, zero, 9      # allocate heap memory
    ecall
    
    add s3, a0, zero      # s3 = ponteiro para nova string
    add s4, a0, zero      # s4 = cópia do início para impressão
    
    # Copiar str1 para a nova área
    la s0, str1           # ponteiro para str1
    
loop_str1:
    lb t0, 0(s0)          # pega o byte de str1
    beq t0, zero, fim_str1 # se for \0, termina
    sb t0, 0(s3)          # coloca no buffer
    addi s0, s0, 1        # próximo byte de str1
    addi s3, s3, 1        # próxima posição no buffer
    j loop_str1
    
fim_str1:
    # Copiar str2 para a nova área
    la s0, str2           # ponteiro para str2
    
loop_str2:
    lb t0, 0(s0)          # pega o byte de str2
    sb t0, 0(s3)          # coloca no buffer
    beq t0, zero, fim_str2 # se for \0, termina
    addi s0, s0, 1        # próximo byte de str2
    addi s3, s3, 1        # próxima posição no buffer
    j loop_str2
    
fim_str2:
    # Imprimir resultado
    add a0, s4, zero      # endereço da string concatenada
    addi a7, zero, 4      # print string
    ecall
    
    # Exit
    addi a7, zero, 10
    ecall