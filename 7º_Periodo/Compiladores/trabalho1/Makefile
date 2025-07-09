# Makefile para o Analisador Léxico LALG

# Compiladores e flags
CC = gcc
CFLAGS = -g -Wall
LEX = flex

# Arquivos fonte
LEX_SOURCE = lalg_lex.l
EXECUTABLE = analisador_lexico

# Diretório de testes
TEST_DIR = testes

# Curinga para pegar todos os arquivos .lalg no diretório de testes
TESTS_IN := $(wildcard $(TEST_DIR)/*.lalg)
TESTS_OUT := $(TESTS_IN:$(TEST_DIR)/%.lalg=$(TEST_DIR)/%_out)

# Target principal: compila o analisador léxico
all: $(EXECUTABLE)

# Regra para gerar o arquivo C do Flex a partir do .l
lex.yy.c: $(LEX_SOURCE)
	@echo "Gerando código C do lexer com Flex..."
	$(LEX) $(LEX_SOURCE)

# Regra para compilar o arquivo C gerado e criar o executável
$(EXECUTABLE): lex.yy.c
	@echo "Compilando o executável $(EXECUTABLE)..."
	$(CC) lex.yy.c -o $(EXECUTABLE) $(CFLAGS)

# Regra para executar todos os testes
run: clean_tests $(TESTS_OUT)
	@echo "Todos os testes foram executados. Verifique os arquivos de saída em $(TEST_DIR)/"

# Regra para cada arquivo de teste
$(TEST_DIR)/%_out: $(TEST_DIR)/%.lalg $(EXECUTABLE)
	@echo "Executando teste $<..."
	# Executa o analisador. Redireciona stdout para um temp_out e stderr para um temp_err_out.
	./$(EXECUTABLE) < $< > $(TEST_DIR)/tmp_lexer_out 2> $(TEST_DIR)/tmp_err_out
		
	cat $(TEST_DIR)/tmp_lexer_out >> $@ # Adiciona a saída do analisador léxico
	
	cat $(TEST_DIR)/tmp_err_out >> $@ # Adiciona os erros (se houver) ao arquivo de saída
	
	# Remove os arquivos temporários
	rm -f $(TEST_DIR)/tmp_lexer_out
	rm -f $(TEST_DIR)/tmp_err_out

# Regra para limpar todos os arquivos gerados pelo Makefile
clean: clean_tests
	@echo "Limpando arquivos gerados..."
	rm -f $(EXECUTABLE)
	rm -f lex.yy.c
	find . -name "*~" | xargs rm -rf

# Regra para limpar apenas os arquivos de saída dos testes
clean_tests:
	@echo "Limpando saídas de testes..."
	rm -f $(TEST_DIR)/*_out
	rm -f $(TEST_DIR)/tmp_lexer_out
	rm -f $(TEST_DIR)/tmp_err_out

# Regra para verificar vazamento de memória com Valgrind
memcheck: $(EXECUTABLE)
	@echo "Verificando vazamento de memória para $(word 1,$(TESTS_IN))..."
	valgrind --tool=memcheck --leak-check=full ./$(EXECUTABLE) < $(word 1,$(TESTS_IN))

.PHONY: all run clean clean_tests memcheck