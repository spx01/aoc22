import unittest
import sugar
import utils

test "iterators":
    check @[1, 2, 3, 4].toIter.fold((s, x: int) => s + x, 0) == 10
    check @[5, 6, 7, 9].toIter
        .map((x: int) => x * 2)
        .enumerate
        .take(3)
        .zip(@[0].toIter)
        .to_seq ==
            @[((0, 10), 0)]
