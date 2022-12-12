dirs = {
    "L": (-1, 0),
    "R": (1, 0),
    "U": (0, -1),
    "D": (0, 1),
}


def visit(head, tail, delta, dist):
    res = set()
    for _ in range(dist):
        tail = (tail[0] - delta[0], tail[1] - delta[1])
        head = (head[0] + delta[0], head[1] + delta[1])
        if abs(tail[0]) > 1 or abs(tail[1]) > 1:
            tail = (-delta[0], -delta[1])
            res |= {(head[0] + tail[0], head[1] + tail[1])}
    return head, tail, res


head = (0, 0)
tail = (0, 0)
ans = {head}
for line in open("input/day9.txt"):
    delta, dist = line.strip().split()
    delta = dirs[delta]
    dist = int(dist)
    head, tail, res = visit(head, tail, delta, dist)
    ans |= res

print(len(ans))

knots = [(0, 0)] * 10
ans = {(0, 0)}


def update(knot=9):
    global ans
    if knot == 0:
        return
    update(knot - 1)
    prev = knots[knot - 1]
    cur = knots[knot]
    dx, dy = prev[0] - cur[0], prev[1] - cur[1]
    if abs(dx) <= 1 and abs(dy) <= 1:
        return
    if dx * dy == 0:
        if dx != 0:
            dx -= 1 if dx > 0 else -1
        elif dy != 0:
            dy -= 1 if dy > 0 else -1
        knots[knot] = (cur[0] + dx, cur[1] + dy)
    else:
        dx = 1 if dx > 0 else -1
        dy = 1 if dy > 0 else -1
        knots[knot] = (cur[0] + dx, cur[1] + dy)
    if knot == 9:
        ans |= {knots[9]}


for line in open("input/day9.txt"):
    delta, dist = line.strip().split()
    delta = dirs[delta]
    dist = int(dist)
    for _ in range(dist):
        knots[0] = (knots[0][0] + delta[0], knots[0][1] + delta[1])
        update()

print(len(ans))
