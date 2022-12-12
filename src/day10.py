clock = 0
ans = 0
reg = 1
clock = 20
k = 0
for line in open("input/day10.txt"):
    add = 0
    if line[0] == "n":
        clock += 1
    else:
        add = int(line.split()[1])
        reg += add
        clock += 2
    if clock >= 40:
        ans += (reg - add) * (k * 40 + 20)
        k += 1
        clock -= 40

print(ans)

skip = False
add = 0
clock = 0
reg = 1
it = iter(open("input/day10.txt"))
for clock in range(240):
    cur = reg - skip * add
    if skip:
        skip = False
    else:
        line = next(it)
        if line[0] == "a":
            add = int(line.split()[1])
            reg += add
            skip = True
    print("#" if cur - 1 <= clock % 40 <= cur + 1 else ".", end="")
    if clock % 40 == 39:
        print()
