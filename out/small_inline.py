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



t = [None] * 2
for d in range(0, 2):
    t[d] = readint()
    stdinsep()
print("%d - %d\n" % (t[0], t[1]), end='')

