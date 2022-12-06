import sugar

template toIter*(x): iterator: auto =
    block:
        iterator it(): auto {.closure.} =
            for y in x:
                yield y
        it

proc toSeq*[T](it: iterator: T): seq[T] =
    for x in it():
        result.add(x)

iterator splitImpl[T](it: iterator: T, isSep: (T) ->
        bool): iterator: T =
    while not it.finished:
        iterator it2(): auto {.closure.} =
            while true:
                let x = it()
                if it.finished or x.isSep:
                    return
                yield x
        yield it2

template split*(it, isSep): iterator: auto =
    splitImpl(it, isSep).toIter

iterator mapImpl[T, U](it: iterator: T, f: (T) -> U): U =
    for x in it():
        yield f(x)

template map*(it, f): iterator: auto =
    mapImpl(it, f).toIter

proc fold*[T, U](it: iterator: T, f: (U, T) -> U, init: U): U =
    var acc = init
    for x in it():
        acc = f(acc, x)
    acc

iterator zipImpl[T, U](it1: iterator: T, it2: iterator: U): (T, U) =
    while true:
        let (x, y) = (it1(), it2())
        if it1.finished or it2.finished:
            break
        yield (x, y)

template zip*[T, U](it1: iterator: T, it2: iterator: U): iterator: auto =
    zipImpl(it1, it2).toIter

iterator infCountupImpl(start, step: int): int =
    var i = start
    while true:
        yield i
        i += step

template infCountup*(start = 0, step = 1): iterator: auto =
    infCountupImpl(start, step).toIter

template enumerate*(it): iterator: auto =
    zip(infCountup(), it)

iterator filterImpl[T](it: iterator: T, f: (T) -> bool): T =
    for x in it():
        if f(x):
            yield x

template filter*(it, f): iterator: auto =
    filterImpl(it, f).toIter

iterator takeImpl[T](it: iterator: T, n: int): T =
    var i = 0
    while i < n:
        let x = it()
        if it.finished:
            break
        yield x
        i += 1

template take*(it, n): iterator: auto =
    takeImpl(it, n).toIter

iterator dropImpl[T](it: iterator: T, n: int): T =
    var i = 0
    while i < n:
        if it().finished:
            break
        i += 1
    while true:
        let x = it()
        if it.finished:
            break
        yield x

template drop*(it, n): iterator: auto =
    dropImpl(it, n).toIter

# TODO: zip with varargs and weld zip (which would join together the tuples)
