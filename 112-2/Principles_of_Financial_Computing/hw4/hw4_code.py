import numpy as np

def xi_array(N, n):
    xi_array = np.zeros((N, n))
    for t in range(n):
        xi_cal = np.random.normal(size = N)
        xi_array[:, t] = xi_cal
    return xi_array

# Monte Carlo simulation
def MC_sim(S, r, s, n, N, dt, xi):
    paths = np.zeros((N, n + 1))
    paths[:, 0] = S
    for i in range(1, n + 1):
        paths[:, i] = paths[:, i - 1] * np.exp((r - (s ** 2) / 2) * dt + s * np.sqrt(dt) * xi[:, i - 1])
    return paths

def mov_avg(paths):
    paths_ma = []
    for path in paths:
        avg_price = np.cumsum(path) / np.arange(1, len(path) + 1)
        paths_ma.append(avg_price)
    return np.array(paths_ma)

def LSM_American_style_Asian_put(S, r, s, n, N, dt, xi, X, df):
    paths = MC_sim(S, r, s, n, N, dt, xi)
    paths_ma = mov_avg(paths) # moving average of paths
    payoffs = np.maximum(X - paths_ma, 0)
    cashflows = np.zeros_like(payoffs)
    cashflows[:, -1] = payoffs[:, -1]
    for t in range(n - 1, 0, -1):
        cashflows[:, t] = df * cashflows[:, t + 1]
        in_the_money = np.where(payoffs[:, t] > 0)[0]
        if len(in_the_money) == 0:
            continue
        Y_axis = cashflows[in_the_money, t]
        X_axisT = np.vstack([
            np.ones(len(in_the_money)), 
            paths_ma[in_the_money, t], 
            paths_ma[in_the_money, t] ** 2
        ])
        X_axis = X_axisT.T
        coef = np.linalg.lstsq(X_axis, Y_axis, rcond = None)[0] # coefficients
        cont_val = np.dot(X_axis, coef) # continuation values
        exe_val = payoffs[in_the_money, t] # exercise values
        early_exe = np.where(exe_val > cont_val)[0] # early exercise
        if len(early_exe) == 0:
            continue
        cashflows[in_the_money[early_exe], t] = exe_val[early_exe]
        cashflows[in_the_money[early_exe], t+1:] = 0
    put_price = df * np.mean(cashflows[:, 1])
    return put_price


if __name__ == "__main__":
    import sys
    args = sys.argv[1:]
    S, X, T, r, s, n, N = map(float, args)
    T, n, N = int(T), int(n), int(N)
    
    dt = (T / 365) / n
    df = np.exp(-r * dt) # discount factor
    xi = xi_array(N, n)
    
    price = round(LSM_American_style_Asian_put(S, r, s, n, N, dt, xi, X, df), 6)
    price_up = LSM_American_style_Asian_put(S * 1.01, r, s, n, N, dt, xi, X, df)
    price_down = LSM_American_style_Asian_put(S * 0.99, r, s, n, N, dt, xi, X, df)
    delta = round((price_up - price_down) / (S * 0.02), 6)
   
    print(str(price) + "," + str(delta))