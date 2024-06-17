import numpy as np

def Lambda_cal(barrier, stock_price, sigma, dt):
    upmoves = np.floor(np.log(barrier / stock_price) / (sigma * np.sqrt(dt)))
    Lambda = np.log(barrier / stock_price) / (upmoves * sigma * np.sqrt(dt))
    return upmoves, Lambda

def Tri_cal(sigma, r, dt, Lambda):
    u = np.exp(Lambda * sigma * np.sqrt(dt))
    miu = r - 0.5 * sigma ** 2
    Pu = 1 / (2 * Lambda ** 2) + miu * np.sqrt(dt) / (2 * Lambda * sigma)
    Pm = 1 - 1 / Lambda ** 2
    Pd = 1 - Pu - Pm
    return u, Pu, Pm, Pd

def tri_price(n, t0_price, u):
    prices = np.zeros((n + 1, 2 * n + 1))
    for i in range(n + 1):
        for j in range (2 * i + 1):
            prices[i, j] = t0_price * (u ** (i - j))
    return prices

def tri_UpAndOut_put(n, Pu, Pm, Pd, r, tri_stock, upmoves):
    put = np.zeros((n + 1, 2 * n + 1))
    tri_put_payoff = np.maximum(0, X - tri_stock)
    put[-1] = tri_put_payoff[-1]
    for i in range(n-1, -1, -1):
        for j in range (2 * i + 1):
            if i - j >= upmoves:
                put[i, j] = 0
            else:
                put[i, j] = np.exp(-r * dt) * (Pu * put[i + 1, j] + Pm * put[i + 1, j + 1] + Pd * put[i + 1, j + 2])
    return put[0, 0]

if __name__ == "__main__":
    import sys
    args = sys.argv[1:]
    S, X, r, s, T, H, n = map(float, args)
    T, n = int(T), int(n)
    
    dt = (T / 365) / n
    h, Lambda = Lambda_cal(H, S, s, dt)
    u, Pu, Pm, Pd = Tri_cal(s, r, dt, Lambda)
    tri_stock = tri_price(n, S, u)
    
    output = round(tri_UpAndOut_put(n, Pu, Pm, Pd, r, tri_stock, h), 6)
    print(output)
    