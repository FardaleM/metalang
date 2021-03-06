#include <iostream>
#include <vector>
#include <algorithm>

std::vector<int> * primesfactors(int n) {
    std::vector<int> *tab = new std::vector<int>( n + 1 );
    std::fill(tab->begin(), tab->end(), 0);
    int d = 2;
    while (n != 1 && d * d <= n)
        if (n % d == 0)
        {
            tab->at(d)++;
            n /= d;
        }
        else
            d++;
    tab->at(n)++;
    return tab;
}

int main() {
    int lim = 20;
    std::vector<int> *o = new std::vector<int>( lim + 1 );
    std::fill(o->begin(), o->end(), 0);
    for (int i = 1; i <= lim; i++)
    {
        std::vector<int> * t = primesfactors(i);
        for (int j = 1; j <= i; j++)
            o->at(j) = std::max(o->at(j), t->at(j));
    }
    int product = 1;
    for (int k = 1; k <= lim; k++)
        for (int l = 1; l <= o->at(k); l++)
            product *= k;
    std::cout << product << "\n";
}

