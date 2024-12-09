#include <bits/stdc++.h>
using namespace std;
const long long MOD = 1000000007;

//(base^exp) % mod usando exp modular
long long modular_exponentiation(long long base, long long exp, long long mod) {
    long long result = 1;
    while (exp > 0) {
        if (exp % 2 == 1) { //se o exp eh impar
            result = (result * base) % mod;
        }
        base = (base * base) % mod;
        exp /= 2;
    }
    return result;
}

int main() {
    int n;
    std::cin >> n;  

    for (int i = 0; i < n; ++i) {
        long long a, b, c;
        std::cin >> a >> b >> c;

        long long exp = modular_exponentiation(b, c, MOD - 1);

        long long result = modular_exponentiation(a, exp, MOD);

        std::cout << result << "\n";
    }

    return 0;
}
