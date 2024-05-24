public class Dado 
{
    private int lados;
    private int ladoCima;
    private Random rand;
    
    public Dado() 
    {
        lados = 6;
        rand = new Random();
        rolar();
    }
    
    public Dado(int n) 
    {
        if (n <= 1) throw new IllegalArgumentException("O numero de lados deve ser maior que 1");
        rand = new Random();
        lados = n;
        rolar();
    }


    /**
     * Recupera o último número selecionado.
     */
    public int getLado() 
    {
        return ladoCima;
    }

    /**
     * Não tem função real dentro da classe. 
     * Foi usada apenas para testar os métodos implementados
     */
    public static void main(String[] args)
    {
		Dado d = new Dado();
		d.rolar();
		System.out.println("Lado sorteado: \n"+d);
	}

    /**
     * Transforma representação do dado em String. 
     * É mostrada uma representação do dado que está para cima. 
     * Note que só funciona corretamente para dados de 6 lados.
     */
    @Override
	public String toString() 
    {
        String r = "";

		switch(ladoCima) 
        {
            case 1: 
            r += "+-----+\n"; 
            r += "|     |\n"; 
            r += "|  *  |\n"; 
            r += "|     |\n"; 
            r += "+-----+\n"; 
            break;
			case 2: 
            r += "+-----+\n"; 
            r += "|    *|\n"; 
            r += "|     |\n"; 
            r += "|*    |\n"; 
            r += "+-----+\n"; 
            break;
			case 3: 
            r += "+-----+\n"; 
            r += "|    *|\n"; 
            r += "|  *  |\n"; 
            r += "|*    |\n"; 
            r += "+-----+\n"; 
            break;
			case 4: 
            r += "+-----+\n"; 
            r += "|*   *|\n"; 
            r += "|     |\n"; 
            r += "|*   *|\n"; 
            r += "+-----+\n"; 
            break;
			case 5: 
            r += "+-----+\n"; 
            r += "|*   *|\n"; 
            r += "|  *  |\n"; 
            r += "|*   *|\n"; 
            r += "+-----+\n"; 
            break;
			case 6: 
            r += "+-----+\n"; 
            r += "|*   *|\n"; 
            r += "|*   *|\n"; 
            r += "|*   *|\n"; 
            r += "+-----+\n"; 
            break;
		}
		return r;
	}
    
    /**
     * Simula a rolagem do dado por meio de um gerador aleatório.
     * O número selecionado pode posteriormente ser recuperado com a chamada a getLado()
     */
    public int rolar() 
    {
		try 
        {
			ladoCima = rand.getIntRand(1, lados+1);
		} 
        catch(IllegalArgumentException e) 
        {
			System.out.println("Número de lados inválido");
		}	
		
		return getLado();
	}

}
