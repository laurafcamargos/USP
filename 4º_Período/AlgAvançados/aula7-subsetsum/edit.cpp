#include <bits/stdc++.h>
using namespace std;

bool ehVogal(char c) {
    return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
}

pair<int, string> DistMin(string s1, string s2) {
    int m = s1.length();
    int n = s2.length();

    // Usando duas linhas para otimizar o uso de memória
    vector<int> prev(n + 1), curr(n + 1);
    vector<string> prevOp(n + 1), currOp(n + 1);  

    //(caso base)
    for (int j = 0; j <= n; j++) {
        prev[j] = j * 2;
        if (j > 0) prevOp[j] = prevOp[j - 1] + "I:" + s2[j - 1] + " ";
    }

    for (int i = 1; i <= m; i++) {
        curr[0] = i * 2;  
        currOp[0] = prevOp[0] + "R:" + s1[i - 1] + " ";

        for (int j = 1; j <= n; j++) {
            if (s1[i - 1] == s2[j - 1]) {
                curr[j] = prev[j - 1];
                currOp[j] = prevOp[j - 1];
            } else {
                int trocaCusto = (ehVogal(s1[i - 1]) == ehVogal(s2[j - 1])) ? 1 : 3;

                int inserir = curr[j - 1] + 2;
                int remover = prev[j] + 2;
                int trocar = prev[j - 1] + trocaCusto;

                curr[j] = min({inserir, remover, trocar});

                if (curr[j] == inserir) {
                    currOp[j] = currOp[j - 1] + "I:" + s2[j - 1];
                } else if (curr[j] == remover) {
                    currOp[j] = prevOp[j] + "R:" + s1[i - 1];
                } else {
                    currOp[j] = prevOp[j - 1] + "T:" + s1[i - 1] + "-" + s2[j - 1];
                }
            }
        }

        // Troca as linhas para a próxima iteração
        swap(prev, curr);
        swap(prevOp, currOp);
    }

    // O resultado estará na última célula da linha anterior (que agora é 'prev')
    return {prev[n], prevOp[n]};
}

int main() {
    string s1, s2;
    cin >> s1 >> s2;

    auto result = DistMin(s1, s2);

    if (result.first == 0) {
        cout << 0 << endl;
        cout << "nada a fazer" << endl;
    } else {
        cout << result.first << endl;
        cout << result.second << endl;
    }

    return 0;
}
