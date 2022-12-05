import strutils
import iterutils
import sugar
from sequtils import nil

template to_first_class_iter(x): untyped =
    iterator it(): auto {.closure.} =
        for y in x: yield y
    it

# god bless copilot
template chunks[T](x: iterable[T], n: int): untyped =
    iterator it(): auto {.closure.} =
        var i = 0
        var chunk = newSeq[T](n)
        for y in x:
            chunk[i] = y
            i += 1
            if i == n:
                yield chunk
                i = 0
                chunk = newSeq[T](n)
        if i > 0:
            yield chunk[0..i-1]
    it

proc priority(c: char): int =
    c.toLowerAscii.int - 'a'.int + 1 + 26 * c.isUpperAscii.int

proc parse_rucksack(s: string): int =
    let n = s.len
    var set1 = sequtils.foldl(s[0 ..< n div 2], a + {b}, set[char]({}))
    sequtils.foldl(s[n div 2 ..< n],
    block:
        let r = a + (b in set1).int * priority(b)
        set1.excl(b)
        r
    , 0)

proc find_badge(rucksacks: seq[string]): int =
    var count_table: array[52, int]
    for r in rucksacks:
        var current_set = set[char]({})
        for c in r:
            if c in current_set:
                continue
            current_set.incl(c)
            let p = priority(c)
            if count_table[p - 1] == 2:
                return p
            count_table[p - 1] += 1

when isMainModule:
    block:
        "input/day3.txt".lines.to_first_class_iter
            .foldl((x: int, y: string) => x + parse_rucksack(y), 0)
            .echo
    block:
        "input/day3.txt".lines
            .chunks(3)
            .foldl((x: int, y: seq[string]) => x + find_badge(y), 0)
            .echo
