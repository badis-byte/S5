import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import chisquare, kstest

# --- Middle square generator ---
def middle_square(seed, n):
    u = []
    x = seed
    for _ in range(n):
        sq = str(x**2)[2:]  
        sq = sq.ljust(8, "0")[:8]  
        mid = sq[2:6]
        x = int(mid) / 10000
        u.append(x)
    return np.array(u)

# generate 100 random values
u = middle_square(0.2481, 30)
for _ in u :
    print(_)
# --- Histogram ---
plt.hist(u, bins=10, edgecolor='black', density=True)
plt.title("Von Neumann Middle-Square Random Numbers")
plt.xlabel("Value")
plt.ylabel("Frequency")
plt.show()

# --- Chi-square test (10 bins) ---
counts, _ = np.histogram(u, bins=10)
expected = np.full(10, len(u)/10)
chi2, p_chi = chisquare(counts, expected)
print("Chi-square =", chi2, "   p-value =", p_chi)

# --- Kolmogorov-Smirnov Test ---
ks_stat, p_ks = kstest(u, 'uniform')
print("KS stat =", ks_stat, "  p-value =", p_ks)
