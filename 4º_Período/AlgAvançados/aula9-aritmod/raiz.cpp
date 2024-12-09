#include <bits/stdc++.h>
using namespace std;
const long long MOD = 1000000007;

long long modular_exponentiation(long long base, long long exp, long long mod) {
    long long result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}

long long modular_sqrt(long long x, long long p) {
    if (x == 0) {
        return 0; // 
    }
    if (modular_exponentiation(x, (p - 1) / 2, p) != 1) {
        return -1; //n existe raiz quadrada
    }
    
    if (p % 4 == 3) {
        long long root = modular_exponentiation(x, (p + 1) / 4, p);
        return min(root, p - root);
    }

    long long q = p - 1;
    long long s = 0;
    while (q % 2 == 0) {
        q /= 2;
        s += 1;
    }

    long long z = 2;
    while (modular_exponentiation(z, (p - 1) / 2, p) == 1) {
        z += 1;
    }

    long long m = s;
    long long c = modular_exponentiation(z, q, p);
    long long t = modular_exponentiation(x, q, p);
    long long r = modular_exponentiation(x, (q + 1) / 2, p);

    while (t != 0 && t != 1) {
        long long i = 1;
        long long temp = (t * t) % p;
        while (temp != 1) {
            temp = (temp * temp) % p;
            i += 1;
        }

        long long b = modular_exponentiation(c, 1LL << (m - i - 1), p);
        m = i;
        c = (b * b) % p;
        t = (t * c) % p;
        r = (r * b) % p;
    }

    return min(r, p - r); 
}

int main() {
    long long p;
    cin >> p;

    vector<long long> results;
    for (long long x = 0; x < p; ++x) { 
        results.push_back(modular_sqrt(x, p));
    }

    for (size_t i = 0; i < results.size(); ++i) {
        if (i > 0) cout << " ";
        cout << results[i];
    }
    cout << endl;

    return 0;
}
