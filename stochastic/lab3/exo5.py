import numpy as np
import matplotlib.pyplot as plt

def geometric_inverse_transform(p, size=10000):
    # Generate uniform random numbers
    U = np.random.rand(size)

    # Apply inverse transform formula
    X = np.floor(np.log(1 - U) / np.log(1 - p))
    return X.astype(int)

def sumoffive(array, size):
    result =[]
    for i in range(size-5):
        s = 0
        for j in range(5):
            s += array[i+j]
        result.append(s)
        i=i+5
    return result

# Parameters
p = 0.3           
n_samples = 5000 

# Generate samples
samples = geometric_inverse_transform(p, n_samples)

# Display results
print(samples[:10])
print(sumoffive(samples, n_samples)[:10])
print("Mean (simulated):", np.mean(samples))
print("Mean (theoretical):", 1/p)

# Plot histogram
plt.hist(samples, bins=20, density=True)
plt.title("Geometric Distribution via Inverse Transform")
plt.xlabel("k")
plt.ylabel("Probability")
plt.show()
