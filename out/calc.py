
"""La suite de fibonaci"""
def fibo(a, b, i):
    out_ = 0
    a2 = a
    b2 = b
    for j in range(0, i + 2):
        print("%d" % j, end='')
        out_ += a2
        tmp = b2
        b2 += a2
        a2 = tmp
    return out_
print("%d" % fibo(1, 2, 4), end='')

