

n = 10
# normalement on doit mettre 20 mais là on se tape un overflow 

n += 1
tab = [None] * n
for i in range(0, n):
    tab2 = [0] * n
    tab[i] = tab2
for l in range(0, n):
    tab[n - 1][l] = 1
    tab[l][n - 1] = 1
for o in range(2, n + 1):
    r = n - o
    for p in range(2, n + 1):
        q = n - p
        tab[r][q] = tab[r + 1][q] + tab[r][q + 1]
for m in range(0, n):
    for k in range(0, n):
        print("%d " % tab[m][k], end='')
    print("\n", end='')
print("%d\n" % tab[0][0], end='')

