import utils
import deques
import sugar
import strutils
import sequtils

type Move = tuple[n: int, f: int, t: int]

proc parse_move(s: string): Move =
    let words = s.split(" ")
    result.n = parseInt(words[1])
    result.f = parseInt(words[3]) - 1
    result.t = parseInt(words[5]) - 1

proc print_top(stacks: seq[Deque[int]]) =
    sequtils.map(stacks, ((x: Deque[int]) => chr(x.peekFirst + 'A'.ord))).mapIt($it).join.echo

when isMainModule:
    var
        stacks: seq[Deque[int]]
        parsed_lines = 0
    for line in "input/day5.txt".lines().toIter:
        if line[1].isDigit:
            break
        parsed_lines.inc
        var crates_on_level = line.toIter
            .zip(infCountup(3))
            .filter((x: (char, int)) => x[1] mod 4 == 0)
            .map((x: (char, int)) => (if x[0] == ' ': -1 else: x[0].ord - 'A'.ord))
            .toSeq
        if crates_on_level.len > stacks.len:
            stacks = stacks.concat(initDeque[int]().repeat(crates_on_level.len - stacks.len))
        for i in 0 ..< crates_on_level.len:
            if crates_on_level[i] == -1:
                continue
            stacks[i].addLast(crates_on_level[i])

    var stacks1: seq[Deque[int]]
    shallowCopy(stacks1, stacks)
    for line in "input/day5.txt".lines.toIter.drop(parsed_lines + 2):
        let move = parse_move(line)
        for i in 0 ..< move.n:
            stacks1[move.t].addFirst(stacks1[move.f].popFirst())
    print_top(stacks1)

    var stacks2: seq[Deque[int]]
    shallowCopy(stacks2, stacks)
    for line in "input/day5.txt".lines.toIter.drop(parsed_lines + 2):
        let move = parse_move(line)
        var v: seq[int]
        for i in 0 ..< move.n:
            v.add(stacks2[move.f].popFirst())
        for i in countdown(v.len - 1, 0):
            stacks2[move.t].addFirst(v[i])
    print_top(stacks2)
