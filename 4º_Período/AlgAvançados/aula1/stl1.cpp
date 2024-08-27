#include <iostream>
#include <map>
using namespace std;

int main() {
    int T, N;
    map<string, int> assuntos;
    char tema[21];
    int dias, prazo;
    char assunto_pedido[21];

    cin >> T;
    for (int i = 0; i < T; i++) {
        assuntos.clear();


        cin >> N;
        for (int j = 0; j < N; j++) {
            cin >> tema >> dias;
            assuntos[tema] = dias;
        }
        cin >> prazo;
        cin >> assunto_pedido;

        if (assuntos.count(assunto_pedido) > 0) {  
            int D = assuntos[assunto_pedido];  

            if (D <= prazo) {
                cout << "Case " << i + 1 << ": Ufa!" << endl;
            } else if (D > prazo && D <= prazo + 5) {
                cout << "Case " << i + 1 << ": Atrasado" << endl;
            } else {
                cout << "Case " << i + 1 << ": Deu ruim! Va trabalhar" << endl;
            }
        } else {
            cout << "Case " << i + 1 << ": Deu ruim! Va trabalhar" << endl;
        }
    }

    return 0;
}
