from itertools import *
import utils


def n_distinct(msg, n):
    return next(
        i + n for i, x in enumerate(utils.sliding_window(msg, n)) if len(set(x)) == n
    )


msg = open("input/day6.txt", "r").readline()
print(n_distinct(msg, 4))
print(n_distinct(msg, 14))
