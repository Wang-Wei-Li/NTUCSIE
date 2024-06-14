import numpy as np

def CRR_cal(sigma, dt, r):
    u = np.exp(sigma * np.sqrt(dt))
    d = 1 / u
    p = (np.exp(r * dt) - d) / (u - d)
    return u, d, p
    
def bin_price(n, t0_price, u, d):
    prices = np.zeros((n + 1, n + 1))
    for i in range(n + 1):
        for j in range (i + 1):
            prices[i, j] = t0_price * (u ** (i - j)) * (d ** j)
    return prices

def BermudanPut(n, p, r, bin_put_payoff, ex_periods):
    put = np.zeros((n + 1, n + 1))
    put[-1] = bin_put_payoff[-1] 
    for i in range(n-1, -1, -1):
        for j in range (i + 1):
            put[i, j] = np.exp(-r * dt) * (p * put[i + 1, j] + (1 - p) * put[i + 1, j + 1])
            if i in ex_periods:
                put[i, j] = np.maximum(put[i, j], bin_put_payoff[i, j])
    return put[0, 0]

if __name__ == "__main__":
    import sys
    args = sys.argv[1:]
    S, X, r, s, T, m, *E = map(float, args)
    T, m = int(T), int(m)
    E = [int(day) for day in E]
    
    dt = 1 / (365 * m) # tao / n
    n = T * m # number of periods
    u, d, p = CRR_cal(s, dt, r) # u,d: p.299; p: p.304
    
    ex_periods = []
    for day in E:
        for i in range(m-1, -1, -1):
            ex_periods.append(m * day - i)
    
    bin_stock = bin_price(n, S, u, d)
    bin_put_payoff = np.maximum(0, X - bin_stock)
    
    output = round(BermudanPut(n, p, r, bin_put_payoff, ex_periods), 6)
    print(output)