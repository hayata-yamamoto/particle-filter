import numpy as np
from numpy.random import normal, choice
import pandas as pd
from pathlib import Path
import matplotlib.pyplot as plt
import random

def main() -> None:
    random.seed(1985)
    # TODO: remove magic number
    sd_ini = 1.0
    sd_sys = 0.15
    sd_obs = 0.2
    sc_sys = 0.04

    fp = Path(__file__).resolve().parents[1] / 'data' / 'testdata.txt'
    data = pd.read_table(fp, delimiter=' ')

    t_max = data.x.shape[0] + 1
    n_max = 5000

    x = np.zeros((n_max, t_max))
    x[:, 0] = normal(loc=0, scale=sd_ini, size=n_max)
    for t in range(t_max-1):
        x[:, t+1] = x[:, t] + normal(loc=0, scale=sd_sys, size=n_max)
        weight = np.exp(-(x[:, t+1] - data.y.loc[t+1])**2.0 / (2.0 * sd_obs**2.0))
        x[:, t+1] = choice(x[:, t+1], p=weight / np.sum(weight), replace=True)

    r = 3.5
    plt.scatter(data.x, data.y)
    plt.plot(np.arange(1, t_max), data.ytrue)
    [plt.plot(np.arange(1, t_max), seq[1:t_max]) for seq in x[1:5, :]]
    plt.xlim(1, t_max-1)
    plt.ylim(-r, r)
    plt.savefig('fig1.png')
    plt.close()

    plt.scatter(data.x, data.y)
    plt.plot(np.arange(1, t_max), )



if __name__ == "__main__":
    main()
