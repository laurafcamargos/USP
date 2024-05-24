from abc import ABC, abstractmethod

class Funcionario(ABC):
    def __init__(self, nome, cpf, salario_base):
        self.nome = nome
        self.cpf = cpf
        self.salario_base = salario_base

    @staticmethod
    def verificaCPF(cpf):
        cpf = cpf.replace(".", "").replace("-", "")

        # Verificar se o CPF possui 11 dígitos
        if len(cpf) != 11:
            return False

        # Verificar se todos os dígitos são iguais
        if cpf == cpf[0] * 11:
            return False

        # Calcular o primeiro dígito verificador
        soma = sum(int(cpf[i]) * (10 - i) for i in range(9))
        digito1 = (soma * 10) % 11
        if digito1 == 10:
            digito1 = 0

        # Calcular o segundo dígito verificador
        soma = sum(int(cpf[i]) * (11 - i) for i in range(10))
        digito2 = (soma * 10) % 11
        if digito2 == 10:
            digito2 = 0

        # Verificar se os dígitos verificadores estão corretos
        if int(cpf[9]) == digito1 and int(cpf[10]) == digito2:
            return True

        return False

    @abstractmethod #método que não é implementado nessa classe
    def calculaSalario(self):
        pass
