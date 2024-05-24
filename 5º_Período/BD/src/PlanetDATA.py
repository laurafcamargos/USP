import cx_Oracle
import os

def print_text_in_box(text):
    text = "\n" + text
    lines = text.split('\n')
    max_length = max(len(line) for line in lines)

    # Imprime a borda superior
    print('*' * (max_length + 4))

    # Imprime as linhas com bordas laterais
    for line in lines:
        print(f"* {line.ljust(max_length)} *")

    # Imprime a borda inferior
    print('*' * (max_length + 4))

    
def consultar_dados(sistema_planetario):
    try:
        conn_str = 'a13692334/laura2014@orclgrad1.icmc.usp.br:1521/pdb_elaine.icmc.usp.br'
        with cx_Oracle.connect(conn_str) as conn:
            with conn.cursor() as cursor:
                cursor.execute("""
                    SELECT NOME, IDADE
                    FROM PLANETA
                    WHERE UPPER(SISTEMA_PLANETARIO) = :sistema
                """, {'sistema': sistema_planetario.upper()})

                resultados = cursor.fetchall()

                if resultados:
                    print(f"Planetas no sistema {sistema_planetario}:\n")
                    for nome_planeta, idade_planeta in resultados:
                        print(f"Nome: {nome_planeta}\nIdade(em bilhões de anos): {idade_planeta}\n")
                else:
                    print(f"Nenhum planeta encontrado para o {sistema_planetario}.")

    except cx_Oracle.Error as err:
        print('Erro ao conectar ao banco de dados')
        print(err)


def ler_numero(mensagem, msg_err, digit_amt=None):
    while True:
        num = input(mensagem).strip()

        try:
            # Tenta converter para float e verifica se é um número válido
            float_num = float(num.replace(',', '.'))
            break
        except ValueError:
            print("\n" + msg_err + "\n")

        if digit_amt is not None and not num.isdigit():
            print("\nEntre um número de " + str(digit_amt) + " dígitos.\n")

    return float_num

def inserir_dados():
    try:
        conn_str = 'a13692334/laura2014@orclgrad1.icmc.usp.br:1521/pdb_elaine.icmc.usp.br'
        with cx_Oracle.connect(conn_str) as conn:
            with conn.cursor() as cursor:
                nome_planeta = input("Digite o nome do planeta: ").strip().upper()

                idade_planeta = ler_numero(
                    "Digite a idade do planeta (em bilhões de anos): ",
                    "Entrada inválida. Por favor, digite a idade usando um ponto como separador decimal."
                )

                sistema_planetario_escolhido = input_sistema_planetario_valido("Escolha um sistema planetário: ")

                cursor.execute("""
                    INSERT INTO PLANETA (NOME, IDADE, SISTEMA_PLANETARIO)
                    VALUES (:nome, :idade, :sistema_planetario)
                """, {'nome': nome_planeta, 'idade': idade_planeta, 'sistema_planetario': sistema_planetario_escolhido})

                conn.commit()

                print("\nInserção de dados bem-sucedida!\n")

    except cx_Oracle.Error as e:
        print("\nErro ao inserir dados no banco de dados:")
        print(e)
        if conn:
            conn.rollback()
    

def input_sistema_planetario_valido(message):
    SISTEMAS_VALIDOS = [
        'SISTEMA SOLAR', 'SISTEMA ALPHA', 'SISTEMA BETA', 'SISTEMA DELTA', 'SISTEMA GAMA'
    ]

    print("Sistemas Planetários válidos:")
    for i, sistema in enumerate(SISTEMAS_VALIDOS, start=1):
        print(f"{i} - {sistema}")
    
    while True:
        try:
            opcao = int(input(message))
            if opcao in range(1, len(SISTEMAS_VALIDOS) + 1):
                print("\tSistema Planetário selecionado: " + SISTEMAS_VALIDOS[opcao - 1])
                return SISTEMAS_VALIDOS[opcao - 1]
            else:
                print("\nOpção inválida. Por favor, escolha um número correspondente a um sistema planetário válido.\n")
        except ValueError:
            print("\nEntrada inválida. Por favor, digite um número.\n")

def main():
    print_text_in_box("OLÁ, SEJA BEM-VINDO AO PLANETDATA!\n")

    while True:
        print("\nO que deseja fazer?")
        print("  1 - Consultar planetas existentes em algum sistema planetário.")
        print("  2 - Inserir dados de um novo planeta.")
        print("  3 - Sair.")
    
        command = input("Digite o código do comando: ").strip()

        # Limpar a tela
        os.system('cls' if os.name == 'nt' else 'clear')

        if command == '1':
            try:
                sistema_planetario = input_sistema_planetario_valido("Escolha o nome do sistema planetário: ")
                consultar_dados(sistema_planetario)
            except Exception as e:
                print(f"\nErro ao consultar dados: {str(e)}")
        elif command == '2':
            try:
                inserir_dados()
            except Exception as e:
                print(f"\nErro ao inserir dados: {str(e)}")
        elif command == '3':
            print("\nAté uma próxima!\n")
            break
        else:
            print("\nComando inválido. Por favor, tente novamente\n.")

if __name__ == "__main__":

    print("Versão do cx_Oracle:", cx_Oracle.__version__)

    main()