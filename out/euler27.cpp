#include <iostream>
#include <vector>

int eratostene(std::vector<int>& t, int max0) {
    int n = 0;
    for (int i = 2; i < max0; i += 1)
        if (t[i] == i)
        {
            n += 1;
            int j = i * i;
            while (j < max0 && j > 0)
            {
                t[j] = 0;
                j += i;
            }
        }
    return n;
}


bool isPrime(int n, std::vector<int>& primes, int len) {
    int i = 0;
    if (n < 0)
        n = -n;
    while (primes[i] * primes[i] < n)
    {
        if (n % primes[i] == 0)
            return false;
        i += 1;
    }
    return true;
}


int test(int a, int b, std::vector<int>& primes, int len) {
    for (int n = 0; n <= 200; n += 1)
    {
        int j = n * n + a * n + b;
        if (!isPrime(j, primes, len))
            return n;
    }
    return 200;
}


int main(void) {
    int maximumprimes = 1000;
    std::vector<int> era( maximumprimes );
    for (int j = 0; j < maximumprimes; j += 1)
        era[j] = j;
    int result = 0;
    int max0 = 0;
    int nprimes = eratostene(era, maximumprimes);
    std::vector<int> primes( nprimes, 0 );
    int l = 0;
    for (int k = 2; k < maximumprimes; k += 1)
        if (era[k] == k)
        {
            primes[l] = k;
            l += 1;
        }
    std::cout << l << " == " << nprimes << "\n";
    int ma = 0;
    int mb = 0;
    for (int b = 3; b <= 999; b += 1)
        if (era[b] == b)
            for (int a = -999; a <= 999; a += 1)
            {
                int n1 = test(a, b, primes, nprimes);
                int n2 = test(a, -b, primes, nprimes);
                if (n1 > max0)
                {
                    max0 = n1;
                    result = a * b;
                    ma = a;
                    mb = b;
                }
                if (n2 > max0)
                {
                    max0 = n2;
                    result = -a * b;
                    ma = a;
                    mb = -b;
                }
            }
    std::cout << ma << " " << mb << "\n" << max0 << "\n" << result << "\n";
    return 0;
}

