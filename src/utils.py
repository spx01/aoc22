import collections
from itertools import *


def sliding_window(iterable, n):
    it = iter(iterable)
    window = collections.deque(islice(it, n), maxlen=n)
    if len(window) == n:
        yield tuple(window)
    for x in it:
        window.append(x)
        yield tuple(window)


def deduped(xs, default=-1):
    def go(xs, prev=None, first=True):
        if not xs:
            return []
        x = xs[0]
        call = go(xs[1:], x, False)
        if first:
            return [x] + call
        return [x if x != prev else default] + call

    return go(xs)


def transposed(xs):
    return list(map(list, zip(*xs)))


def flattened(xs):
    return list(chain.from_iterable(xs))
