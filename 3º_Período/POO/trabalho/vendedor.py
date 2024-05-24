from funcionario import Funcionario

class Vendedor(Funcionario):
    def __init__(self, nome, cpf, salario_base, comissao):
        super().__init__(nome, cpf, salario_base)
        self.comissao = comissao

    def calculaSalario(self):
        return self.salario_base + self.comissao