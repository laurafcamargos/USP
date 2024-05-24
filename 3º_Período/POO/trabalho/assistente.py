from funcionario import Funcionario

class Assistente(Funcionario):

    def _init_(self, salarioBase, nome, cpf):
        super()._init_(salarioBase, nome, cpf)
        
    def calculaSalario(self):
        return self.salario_base
