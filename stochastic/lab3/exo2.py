import matplotlib.pyplot as plt

def congr_rndm(y_n_1 , a, b, m):
    return ((a*y_n_1 + b) % m )/m


# Parameters
a = 1
b = 1
m = 9887     # you used 67 here
seed = 27

# Generate 30 values
values = []
for _ in range(30):
    seed = congr_rndm(seed, a, b, m)
    values.append(seed)
    print(seed/9887)

# --------------------------
# Histogram
# --------------------------
plt.hist(values, bins=10, edgecolor='black')
plt.title("Histogram of LCG values (normalized)")
plt.xlabel("Value")
plt.ylabel("Frequency")
plt.show()
