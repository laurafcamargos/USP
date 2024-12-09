#include <bits/stdc++.h>
using namespace std;
typedef vector<int> vi;


struct TrieNode {
    unordered_map<char, TrieNode*> filhos;
    int count; //conta quantas palavras passam por este nó

    TrieNode() : count(0) {}
};

class Trie {
private:
    TrieNode* root;

public:
    Trie() {
        root = new TrieNode();
    }

    void adicionar(const string& palavra) {
        TrieNode* atual = root;
        for (char c : palavra) {
            if (!atual->filhos.count(c))
                atual->filhos[c] = new TrieNode();
            atual = atual->filhos[c];
            atual->count++;
        }
    }

    void remover(const string& palavra) {
        TrieNode* atual = root;
        stack<TrieNode*> caminho;
        for (char c : palavra) {
            caminho.push(atual);
            atual = atual->filhos[c];
            atual->count--;
        }

        for (int i = palavra.size() - 1; i >= 0; i--) {
            char c = palavra[i];
            TrieNode* pai = caminho.top();
            caminho.pop();

            if (atual->count == 0) {
                pai->filhos.erase(c);
                delete atual;
            }
            atual = pai;
        }
    }

    int contarPrefixos(const string& prefixo) {
        TrieNode* atual = root;
        for (char c : prefixo) {
            if (!atual->filhos.count(c))
                return 0;
            atual = atual->filhos[c];
        }
        return atual->count;
    }
};

int main() {
    ios::sync_with_stdio(false);
    cin.tie(0);

    int q;
    cin >> q;

    Trie trie;

    while (q--) {
        int t;
        string s;
        cin >> t >> s;

        if (t == 1) {
            trie.adicionar(s);
        } else if (t == 2) {
            trie.remover(s);
        } else if (t == 3) {
            cout << trie.contarPrefixos(s) << '\n';
        }
    }

    return 0;
}
