
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import java.util.Scanner;

class Main {
    static class CountryData {
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

        public CountryData(String nomePais, int confirmados, int mortes, int recuperados, int ativos) {
            this.nomePais = nomePais;
            this.confirmados = confirmados;
            this.mortes = mortes;
            this.recuperados = recuperados;
            this.ativos = ativos;
        }
    }

    public static void main(String[] args) {
        String filename = "dados.csv";
        Scanner inteiros = new Scanner(System.in);

        int n1 = inteiros.nextInt();
        int n2 = inteiros.nextInt();
        int n3 = inteiros.nextInt();
        int n4 = inteiros.nextInt();
        inteiros.close();

        try {
            Stream<String> lines = Files.lines(Paths.get(filename));
            List<CountryData> countries = lines
                    .map(line -> {
                        String[] parts = line.split(",");
                        String name = parts[0];
                        int confirmed = Integer.parseInt(parts[1]);
                        int deaths = Integer.parseInt(parts[2]);
                        int recovered = Integer.parseInt(parts[3]);
                        int active = Integer.parseInt(parts[4]);
                        return new CountryData(name, confirmed, deaths, recovered, active);
                    })
                    .collect(Collectors.toList());

            int totalActive = countries.stream()
                    .filter(country -> country.getConfirmados() >= n1)
                    .mapToInt(CountryData::getAtivos)
                    .sum();

            List<String> topCountries = countries.stream()
                    .sorted(Comparator.comparingInt(CountryData::getAtivos).reversed())
                    .limit(n2)
                    .map(CountryData::getNomePais)
                    .collect(Collectors.toList());

            List<Integer> deathsOfTopCountries = countries.stream()
                    .filter(country -> topCountries.contains(country.getNomePais()))
                    .sorted(Comparator.comparingInt(CountryData::getConfirmados))
                    .limit(n3)
                    .map(CountryData::getMortes)
                    .collect(Collectors.toList());

            List<String> topConfirmedCountries = countries.stream()
                    .sorted(Comparator.comparingInt(CountryData::getConfirmados).reversed()
                            .thenComparing(CountryData::getNomePais))
                    .limit(n4)
                    .map(CountryData::getNomePais)
                    .sorted()
                    .collect(Collectors.toList());

            System.out.println(totalActive);
            deathsOfTopCountries.forEach(deaths -> System.out.println(deaths + " "));
            topConfirmedCountries.forEach(country -> System.out.println(country + " "));

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}