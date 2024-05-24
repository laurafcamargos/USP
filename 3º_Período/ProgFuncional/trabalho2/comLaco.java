import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Scanner;

class Main {
   
    static class DadosPais {
        private String nomePais;
        private int confirmados;
        private int mortes;
        private int recuperados;
        private int ativos;

        public String getNomePais() {
            return nomePais;
        }

        public int getConfirmados() {
            return confirmados;
        }

        public int getMortes() {
            return mortes;
        }

        public int getRecuperados() {
            return recuperados;
        }

        public int getAtivos() {
            return ativos;
        }

        public DadosPais(String nomePais, int confirmados, int mortes, int recuperados, int ativos) {
            this.nomePais = nomePais;
            this.confirmados = confirmados;
            this.mortes = mortes;
            this.recuperados = recuperados;
            this.ativos = ativos;
        }
    }

    //a soma de "Active" de todos os países em que "Confirmed" é maior ou igual a n1
    public static int calcularTotalAtivos(int n1, List<DadosPais> paises) {
        int totalAtivos = 0;
        for (DadosPais pais : paises) {
            if (pais.getConfirmados() >= n1) {
                totalAtivos += pais.getAtivos();
            }
        }
        return totalAtivos;
    }

    //dentre os n2 países com maiores valores de "Active", o "Deaths" dos n3 países com menores valores de "Confirmed"
    public static List<Integer> obterMortesMenorConfirmado(int n2, int n3, List<DadosPais> paises) {
        List<Integer> mortesMenorConfirmado = new ArrayList<>();
        paises.sort(Comparator.comparingInt(DadosPais::getAtivos).reversed());
        List<DadosPais> topPaises = paises.subList(0, Math.min(n2, paises.size()));
        topPaises.sort(Comparator.comparingInt(DadosPais::getConfirmados));
        for (int i = 0; i < Math.min(n3, topPaises.size()); i++) {
            mortesMenorConfirmado.add(topPaises.get(i).getMortes());
        }
        return mortesMenorConfirmado;
    }

    //ss n4 países com os maiores valores de "Confirmed" (em ordem alfabética)
    public static List<String> obterPaisesMaiorConfirmado(int n4, List<DadosPais> paises) {
        List<String> paisesMaiorConfirmado = new ArrayList<>();
        paises.sort(Comparator.comparingInt(DadosPais::getConfirmados).reversed());

        for (int i = 0; i < Math.min(n4, paises.size()); i++) {
            paisesMaiorConfirmado.add(paises.get(i).getNomePais());
        }

        paisesMaiorConfirmado.sort(Comparator.naturalOrder()); 

        return paisesMaiorConfirmado;
    }

    public static void main(String[] args) {
        String nomeArquivo = "dados.csv";
        Scanner scanner = new Scanner(System.in);

        int n1 = scanner.nextInt();
        int n2 = scanner.nextInt();
        int n3 = scanner.nextInt();
        int n4 = scanner.nextInt();
        scanner.close();

        List<DadosPais> paises = new ArrayList<>();

        try {
            BufferedReader reader = new BufferedReader(new FileReader(nomeArquivo));
            String linha;
            while ((linha = reader.readLine()) != null) {
                String[] partes = linha.split(",");
                String nome = partes[0];
                int confirmados = Integer.parseInt(partes[1]);
                int mortes = Integer.parseInt(partes[2]);
                int recuperados = Integer.parseInt(partes[3]);
                int ativos = Integer.parseInt(partes[4]);
                paises.add(new DadosPais(nome, confirmados, mortes, recuperados, ativos));
            }
            reader.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        int totalAtivos = calcularTotalAtivos(n1, paises);
        List<Integer> mortesMenorConfirmado = obterMortesMenorConfirmado(n2, n3, paises);
        List<String> paisesMaiorConfirmado = obterPaisesMaiorConfirmado(n4, paises);

        System.out.println(totalAtivos);
        for (int mortes : mortesMenorConfirmado) {
            System.out.println(mortes);
        }
        for (String pais : paisesMaiorConfirmado) {
            System.out.println(pais);
        }
    }
}