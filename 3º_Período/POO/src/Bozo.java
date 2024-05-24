/**
 * Aluna: Gabriela Rodrigues do Prado 
 * NUSP: 11892917
 */

public class Bozo 
{
	/**
	 * Método inicial do programa. Ele cuida da execução do jogo e possui um laço, 
	 * no qual cada iteração representa uma rodada do jogo. Em cada rodada, 
	 * o jogador joga os dados até 3 vezes e depois escolhe a posição do placar que deseja preencher. 
	 * No final das rodadas a pontuação total é exibida.
	*/
	public static void main(String[] args) throws java.io.IOException
	{
		Placar placar = new Placar();
		RolaDados dados= new RolaDados(5);
		
		int[] sorteados = new int[5];
		int aux;
		String ler = "";
		boolean isTrue = true;
		
		for(int i = 0; i < 10; i++) 
		{
			System.out.print("Pressione enter para iniciar a rodada "+ (i+1));
			
			EntradaTeclado.leString();
			
			sorteados = dados.rolar();
			System.out.println(dados);
			
			System.out.println("Digite os números dos dados a serem rolados novamente (ex: 1 2 5) : ");		
			
			while(isTrue) 
			{
				try 
				{
					ler = EntradaTeclado.leString();
					sorteados = dados.rolar(ler);
					break;
				} 
				catch (NumberFormatException e)
				{ 
					System.out.println("Entrada inválida, digite novamente: ");
				}
			}
			System.out.println(dados);
			
			System.out.println("Digite os números dos dados a serem rolados novamente (ex: 1 2 5) : ");
			while(isTrue) 
			{
				try 
				{
					ler = EntradaTeclado.leString();
					sorteados = dados.rolar(ler);
					break;
				} 
				catch (NumberFormatException e)
				{
					System.out.println("Entrada inválida, digite novamente: ");
				}
			}
			
			System.out.println(dados);
			
			System.out.print("Placar atual: "+ placar);
			
			System.out.println("Selecione qual posição quer ocupar: ");
			while(isTrue) 
			{
				try
				{
					aux = EntradaTeclado.leInt();
					placar.add(aux-1, sorteados);
					if(aux > 10 || aux < 1) throw new IllegalArgumentException("");
					break;
				} 
				catch (IllegalArgumentException e) 
				{ 
					System.out.println("Posição inválida ou já preenchida, digite novamente: ");
				}
			}
			
			System.out.print("Placar atualizado: " + placar);
			
		}
		
		System.out.print("\nPontos obtidos: " + placar.getScore());
	}

}

