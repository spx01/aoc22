import strutils
from sequtils import nil
import iterutils
import sugar

template to_first_class_iter(x): untyped =
    iterator it(): auto {.closure.} =
        for y in x: yield y
    it

type Segment = (int, int)

proc to_segment(a: openArray[int]): Segment =
    result = (a[0], a[1])

proc parse_segments(line: string): (Segment, Segment) =
    let parts = line.split(",")
    result[0] = sequtils.map(parts[0].split('-'), parseInt).to_segment
    result[1] = sequtils.map(parts[1].split('-'), parseInt).to_segment

proc has_inclusion(a, b: Segment): bool =
    if b[0] < a[0]:
        return has_inclusion(b, a)
    a[1] >= b[1] or a[0] == b[0]

proc has_intersection(a, b: Segment): bool =
    if b[0] < a[0]:
        return has_intersection(b, a)
    a[1] >= b[0] or a[0] == b[0]

when isMainModule:
    block:
        "input/day4.txt".lines.to_first_class_iter
            .map(parse_segments)
            .foldl((a: int, b: (Segment, Segment)) =>
                a + int(has_inclusion(b[0], b[1])), 0)
            .echo

    block:
        "input/day4.txt".lines.to_first_class_iter
            .map(parse_segments)
            .foldl((a: int, b: (Segment, Segment)) =>
                a + int(has_intersection(b[0], b[1])), 0)
            .echo

