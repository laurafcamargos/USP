public class RolaDados 
{
	private Dado[] dados;
	private int dadosc;

	/**
	* Construtor que cria e armazena vários objetos do tipo Dado. 
	* Usa para isso o construtor padrão daquela classe, ou seja, 
	* um dado de 6 lados e gerando sempre uma semente aleatória para o gerador de números aleatórios. 
	* Os dados criados podem ser referenciados por números, entre 1 e n.
	*/
	public RolaDados(int n) 
	{
		if (n < 1) throw new IllegalArgumentException("o numero de dados tem que ser maior que zero");
		
		dadosc = n;
		dados = new Dado[n];
		
		for (int i = 0; i < dadosc; ++i) dados[i] = new Dado();
	}
	
	/**
	 * Rola todos os dados.
	 */
	public int[] rolar() 
	{
		int[] ret = new int [dadosc];
		
		for (int i = 0; i < dadosc; ++i) ret[i] = dados[i].rolar();
		
		return ret;
	}
	
	/**
	 * Rola alguns dos dados.
	 */
	public int[] rolar(boolean[] quais) 
	{
		int[] ret = new int [dadosc];
		
		for (int i = 0; i < dadosc; ++i)
		{
			if (quais[i]) ret[i] = dados[i].rolar();
		}
		return ret;
	}
	
	/**
	 * Rola alguns dos dados.
	 */
	public int[] rolar(String s) 
	{
		int [] ret = new int [dadosc];
		if(!s.isEmpty()) 
		{
			String[] sstr = s.split(" ");
			
			for (int i = 0; i < sstr.length; ++i) 
			{
				int pos = Integer.parseInt(sstr[i]);
				if (pos > 0 && pos <= dadosc) dados[pos - 1].rolar();
			}
		}
		
		for (int i = 0; i < dadosc; ++i) ret[i] = dados[i].getLado();
		
		return ret;
	}

	/**
	 * Usa a representação em string do dados, para mostrar o valor de todos os dados do conjunto. Exibe os dados horizontalmente.
	 */
	@Override
	public String toString() 
	{
		String ret = "";
		String[][] sstr = new String[dadosc][];
		
		for (int i = 0; i < dadosc; ++i) sstr[i] = dados[i].toString().split("\\n");
		
		for (int i = 0; i < dadosc; ++i) 
		{
			ret += i + 1;
			ret += "       ";
		}
		
		ret += '\n';

		for (int i = 0; i < sstr.length; ++i) 
		{
			for (int j = 0; j < dadosc; ++j) ret += sstr[j][i] + ' ';
			ret += '\n';
		}
		
		ret += '\n';
		return ret;
	}
	
	public static void main(String[] args) 
	{
		RolaDados rolaDados = new RolaDados(5);
		System.out.println(rolaDados);

		rolaDados.rolar();
		System.out.println(rolaDados);
		
		boolean[] b = new boolean[] {false, false, true, false, false};
		rolaDados.rolar(b);
		System.out.println(rolaDados);
		
		rolaDados.rolar("2 5 6");
		System.out.println(rolaDados);
	}
}