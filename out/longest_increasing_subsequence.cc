#include <iostream>
#include <vector>

int dichofind(int len, std::vector<int> * tab, int tofind, int a, int b) {
    if (a >= b - 1)
        return a;
    else
    {
        int c = (a + b) / 2;
        if (tab->at(c) < tofind)
            return dichofind(len, tab, tofind, c, b);
        else
            return dichofind(len, tab, tofind, a, c);
    }
}


int process(int len, std::vector<int> * tab) {
    std::vector<int> *size = new std::vector<int>( len );
    for (int j = 0; j < len; j++)
        if (j == 0)
            size->at(j) = 0;
        else
            size->at(j) = len * 2;
    for (int i = 0; i < len; i++)
    {
        int k = dichofind(len, size, tab->at(i), 0, len - 1);
        if (size->at(k + 1) > tab->at(i))
            size->at(k + 1) = tab->at(i);
    }
    for (int l = 0; l < len; l++)
        std::cout << size->at(l) << " ";
    for (int m = 0; m < len; m++)
    {
        int k = len - 1 - m;
        if (size->at(k) != len * 2)
            return k;
    }
    return 0;
}

int main() {
    int len, n;
    std::cin >> n;
    for (int i = 1; i <= n; i++)
    {
        std::cin >> len;
        std::vector<int> *d = new std::vector<int>( len );
        for (int e = 0; e < len; e++)
        {
            std::cin >> d->at(e);
        }
        std::cout << process(len, d) << "\n";
    }
}

