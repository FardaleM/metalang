import sys
char_ = None

def readchar_():
    global char_
    if char_ == None:
        char_ = sys.stdin.read(1)
    return char_

def skipchar():
    global char_
    char_ = None
    return

def stdinsep():
    while True:
        c = readchar_()
        if c == '\n' or c == '\t' or c == '\r' or c == ' ':
            skipchar()
        else:
            return

def readint():
    c = readchar_()
    if c == '-':
        sign = -1
        skipchar()
    else:
        sign = 1
    out = 0
    while True:
        c = readchar_()
        if c <= '9' and c >= '0' :
            out = out * 10 + int(c)
            skipchar()
        else:
            return out * sign


def copytab(tab, len):
    o = [None] * len
    for i in range(0, len):
        o[i] = tab[i]
    return o
def bubblesort(tab, len):
    for i in range(0, len):
        for j in range(i + 1, len):
            if tab[i] > tab[j]:
                tmp = tab[i]
                tab[i] = tab[j]
                tab[j] = tmp
def qsort0(tab, len, i, j):
    if i < j:
        i0 = i
        j0 = j
        # pivot : tab[0] 
        
        while i != j:
            if tab[i] > tab[j]:
                if i == j - 1:
                    # on inverse simplement
                    
                    tmp = tab[i]
                    tab[i] = tab[j]
                    tab[j] = tmp
                    i += 1
                else:
                    # on place tab[i+1] à la place de tab[j], tab[j] à la place de tab[i] et tab[i] à la place de tab[i+1] 
                    
                    tmp = tab[i]
                    tab[i] = tab[j]
                    tab[j] = tab[i + 1]
                    tab[i + 1] = tmp
                    i += 1
            else:
                j -= 1
        qsort0(tab, len, i0, i - 1)
        qsort0(tab, len, i + 1, j0)
len = 2
len = readint()
stdinsep()
tab = [None] * len
for i_ in range(0, len):
    tmp = 0
    tmp = readint()
    stdinsep()
    tab[i_] = tmp
tab2 = copytab(tab, len)
bubblesort(tab2, len)
for i in range(0, len):
    print("%d " % tab2[i], end='')
print("\n", end='')
tab3 = copytab(tab, len)
qsort0(tab3, len, 0, len - 1)
for i in range(0, len):
    print("%d " % tab3[i], end='')
print("\n", end='')

