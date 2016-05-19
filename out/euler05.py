import math
def mod(x, y):
    return x - y * math.trunc(x / y)

def primesfactors(n):
    tab = [0] * (n + 1)
    d = 2
    while (n != 1 and d * d <= n):
        if mod(n, d) == 0:
            tab[d] = tab[d] + 1
            n = math.trunc(n / d)
        else:
            d += 1
    tab[n] = tab[n] + 1
    return tab

lim = 20
o = [0] * (lim + 1)
for i in range(1, 1 + lim):
    t = primesfactors(i)
    for j in range(1, 1 + i):
        o[j] = max(o[j], t[j])
product = 1
for k in range(1, 1 + lim):
    for l in range(1, 1 + o[k]):
        product *= k
print("%d\n" % (product), end='')

