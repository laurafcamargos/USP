import java.util.Arrays;

public class Placar 
{
	private int[][] dadospos = new int[10][5]; 
	private int[] score = new int[10]; 
	
	public Placar()
	{
		Arrays.fill(score, -2); 
	}

	/**
	 * Adiciona uma sequencia de dados em uma determinada posição do placar. 
	 * Após a chamada, aquela posição torna-se ocupada e não pode ser usada uma segunda vez.
	 */
	public void add(int pos, int[] dados) throws IllegalArgumentException
	{
		if (score[pos] == -2) 
		{
			dadospos[pos] = dados;
			score[pos] = -1;
		} 
		else throw new IllegalArgumentException("Posição inválida ou já preenchida!");
	}

	/**
	 * Computa a soma dos valores obtidos, considerando apenas as posições que já estão ocupadas.
	 */
	public int getScore() 
	{
		int res = 0;
		int aux;
		
		for(int i = 0; i < 10; i++) 
		{
			if(score[i] != -2) 
			{
				score[i] = 0;
				if(i < 6) 
				{
					res += (i+1) * dadosIguais(i, (i+1));
					score[i] = (i+1) * dadosIguais(i, (i+1));
				} 
				else if(i == 6) 
				{
					aux = 0;
					for(int j = 0; j < 6; j++) 
					{
						
						if(dadosIguais(i, j + 1) == 5) 
						{
							res += 15;
							score[i] = 15;
						} 
						else if(dadosIguais(i, j + 1) == 3) aux++;
						
						else if(dadosIguais(i, j + 1) == 2) aux++;

					}
					if(aux == 2) 
					{ 
						res+= 15;
						score[i] = 15;
					}
				} 
				else if(i == 7) 
				{
					aux = 0;
					for(int j = 0; j < 6; j++) 
					{
						if(dadosIguais(i, j + 1) == 1) aux++;
					}
					if(aux == 5) 
					{
						res+= 20;
						score[i] = 20;
					}
				} 
				else if(i == 8) 
				{
					for(int j = 0; j < 6; j++) 
					{
						if(dadosIguais(i, j + 1) == 4) 
						{
							res+= 30;
							score[i] = 30;
						}
							
					}
				} 
				else if(i == 9) 
				{
					for(int j = 0; j < 6; j++) 
					{
						if(dadosIguais(i, j + 1) == 5) 
						{
							res+= 40;
							score[i] = 40;
						}
							
					}
				}
			}			
		}
		
		return res;
	}
	
	/**
	 * Mostra quantas vezes n se repete nos 5 dados de uma posição do placar.
	 */
	private int dadosIguais(int pos, int n) 
	{
		int res = 0;
		for(int i = 0; i < 5; ++i) 
		{
			if(dadospos[pos][i] == n) res++;
		}
		return res;
	}
	
	/**
	 * A representação na forma de string, mostra o placar completo, 
	 * indicando quais são as posições livres (com seus respectivos números) 
	 * e o valor obtido nas posições já ocupadas.
	 */
	@Override
	public String toString() {
		String ret = "\n\n";

		getScore();
		
		if(score[0] == -2) ret += " (1) ";
		else ret += " "+ score[0] +" ";
		ret += " | ";
		if(score[6] == -2) ret += " (7) ";
		else ret += " "+ score[6] +" ";
		ret += " | ";
		if(score[3] == -2) ret += " (4) ";
		else ret += " "+ score[3] +" ";
		ret += "\n";
		ret+= "---------------------\n";
		if(score[1] == -2) ret += " (2) ";
		else ret += " "+ score[1] +" ";
		ret += " | ";
		if(score[7] == -2) ret += " (8) ";
		else ret += " "+ score[7] +" ";
		ret += " | ";
		if(score[4] == -2) ret += " (5) ";
		else ret += " "+ score[4] +" ";
		ret += "\n";
		ret+= "---------------------\n";
		if(score[2] == -2) ret += " (3) ";
		else ret += " "+ score[2] +" ";
		ret += " | ";
		if(score[8] == -2) ret += " (9) ";
		else ret += " "+ score[8] +" ";
		ret += " | ";
		if(score[5] == -2) ret += " (6) ";
		else ret += " "+ score[5] +" ";
		ret += "\n";
		ret += "---------------------\n";
		if(score[9] == -2) ret += "      | (10)  |";
		else ret += "      | "+ score[9] +"  |";
		ret += "\n";
		ret += "      +-------+ \n\n";
		
		return ret;
	}
}
