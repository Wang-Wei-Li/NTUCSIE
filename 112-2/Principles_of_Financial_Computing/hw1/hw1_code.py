def PV_cal(c, m, n, r):
    pv = 0
    for i in range(n * m):
        pv = (pv + c) / (1 + r / m)
    return pv

def PV_cal_var(C, m, n, r):
    pv = 0
    for i in range(m * n):
        pv = (pv + C[m * n -1 - i]) / (1 + r / m)
    return pv

def Payment(PV, m, n, r, e, i):
    a, b = -PV, PV
    pv_a = PV_cal(a, m, n, r)
    pv_mid = float('inf')
    while (abs(pv_mid - PV) > e and i > 0):
        mid = (a + b) / 2
        pv_mid = PV_cal(mid, m, n, r)
        if ((pv_a - PV) * (pv_mid - PV) < 0): b = mid
        else: a = mid
        i -= 1
    return mid

def f_irr(PV, m, n1, c1, n2, c2, irr, F):
    C = [0] * (n1 * m)
    # loan1 cf
    for i in range(n2 * m):
        C[i] += c1
    # loan2 cf
    for i in range(n2 * m, n1 * m):
        C[i] += c2
    C[n2 * m - 1] += F # swap fee
    f_y = - PV + PV_cal_var(C, m, n1, irr)
    return f_y

# approximating irr using Bisection method
def irr_cal(PV, m, r, n1, c1, n2, c2, F, e, i):
    a, b = -1, 100 # initialize x0 and x1
    fa = f_irr(PV, m, n1, c1, n2, c2, a, F)
    fmid = float('inf')
    while (abs(fmid) > e and i > 0):
        mid = (a + b) / 2
        fmid = f_irr(PV, m, n1, c1, n2, c2, mid, F)
        if (fa * fmid < 0): b = mid
        else: a = mid
        i -= 1
        
    if (abs(mid - r) < e): ans = 0
    elif (mid < r): ans = 1
    else: ans = -1
    
    return mid, ans


if __name__ == "__main__":
    import sys
    args = sys.argv[1:]
    V, m, n1, r1, n2, r2, F = map(float, args)
    m, n1, n2 = int(m), int(n1), int(n2)
    epsilon = 0.0000001
    iterations = 100
    
    c1 = Payment(V, m, n1, r1, epsilon, iterations)
    PV_n2 = PV_cal(c1, m, n1 - n2, r1)
    c2 = Payment(PV_n2, m, n1 - n2, r2, epsilon, iterations)
    
    outputs = [0] * 6
    outputs[0] = V - PV_n2
    outputs[1] = c1 * m * n2 - outputs[0]
    outputs[2] = c1 * m * (n1 - n2) - PV_n2
    outputs[3] = c2 * m * (n1 - n2) - PV_n2
    outputs[4], outputs[5] = irr_cal(V, m, r1, n1, c1, n2, c2, F, epsilon, iterations)
    
    outputs = [round(output, 6) for output in outputs]
    print(', '.join(map(str, outputs)))