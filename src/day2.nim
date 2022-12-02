import iterutils
import sugar

type RPS = enum
    R = 1,
    P,
    S,

proc loses_to(p1, p2: RPS): bool =
    ord(p2) == ord(p1) mod 3 + 1

proc score1(p1: RPS, p2: RPS): int =
    if p1 != p2: p2.loses_to(p1).int * 6 + ord(p1)
    else: ord(p1) + 3

template to_first_class_iter(x): untyped =
    iterator it(): auto {.closure.} =
        for y in x: yield y
    it

type LDW = enum
    L,
    D,
    W,

# p1 % 3 == p2 - 1
#
proc score2(p: RPS, r: LDW): int =
    case r
    of L: 3 - (3 - ord(p) + 1) mod 3
    of D: ord(p) + 3
    of W: ord(p) mod 3 + 7

when isMainModule:
    block:
        echo "input/day2.txt".lines.to_first_class_iter.map(
            (s: string) => score1(
                RPS(int(s[2]) - int('X') + 1),
                RPS(int(s[0]) - int('A') + 1),
            )
        ).foldl((a, b: int) => a + b, 0)

    block:
        echo "input/day2.txt".lines.to_first_class_iter.map(
            (s: string) => score2(
                RPS(int(s[0]) - int('A') + 1),
                LDW(int(s[2]) - int('X')),
            )
        ).foldl((a, b: int) => a + b, 0)
