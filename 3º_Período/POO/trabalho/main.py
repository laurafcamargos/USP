from gerente import Gerente
from vendedor import Vendedor
from assistente import Assistente
from funcionario import Funcionario

class TesteFolhaSalarial:
    def main():
        cpfs = ["160.195.846-31", "812.850.660-09", "627.061.440-68", "957.089.940-96", "512.705.360-87", "918.289.200-88"]
        funcionarios = [] #vetor pra guardar os funcionarios validos

        for i in cpfs:
            if Funcionario.verificaCPF(i):
                if i == "160.195.846-31":
                    funcionarios.append(Gerente("Laura", i, 2000))
                elif i == "812.850.660-09":
                    funcionarios.append(Gerente("Luana", i, 2000))
                elif i == "627.061.440-68":
                    funcionarios.append(Assistente("Lucas", i, 2000))
                elif i == "957.089.940-96":
                    funcionarios.append(Assistente("Gustavo", i, 2000))
                elif i == "512.705.360-87":
                    funcionarios.append(Vendedor("Julio", i, 2000, 300))
                elif i == "918.289.200-88":
                    funcionarios.append(Vendedor("Ana", i, 2000, 500))
            else:
                print("CPF inválido:", i)

        total_salarios = 0
        for funcionario in funcionarios:
            salario = funcionario.calculaSalario()
            total_salarios += salario

        print("Valor total: {:.2f}".format(total_salarios))


TesteFolhaSalarial.main()
