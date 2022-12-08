import utils as utl
from itertools import *
from functools import *
from math import prod


forest = list(list(map(int, line.strip())) for line in open("input/day8.txt"))


def visible_horiz(forest):
    m, n = len(forest), len(forest[0])

    def partial_maxes(xs):
        return zip(
            utl.deduped(list(accumulate(xs, max))),
            utl.deduped(list(accumulate(xs[::-1], max)))[::-1],
        )

    return list(
        map(
            lambda line: list(
                map(lambda x: x[0] in x[1], zip(line, partial_maxes(line)))
            ),
            forest,
        )
    )


visible1 = utl.flattened(visible_horiz(forest))
visible2 = utl.flattened(utl.transposed(visible_horiz(utl.transposed(forest))))
print([x or y for x, y in zip(visible1, visible2)].count(True))


def scenic_score(forest, i, j):
    m, n = len(forest), len(forest[0])
    h = forest[i][j]

    def go(i, j, dx, dy):
        ni = i + dx
        nj = j + dy
        if ni < 0 or nj < 0 or ni >= m or nj >= n:
            return 0
        if forest[ni][nj] >= h:
            return 1
        return 1 + go(ni, nj, dx, dy)

    directions = [(1, 0), (0, 1), (-1, 0), (0, -1)]
    return prod(go(i, j, dx, dy) for dx, dy in directions)


m, n = len(forest), len(forest[0])
print(max(scenic_score(forest, i, j) for i, j in product(range(m), range(n))))
