from itertools import *

max_size = 1e5
max_used = 4e7


f = open("input/day7.txt")
it = iter(f)
next(it)
size_table = {}


def dfs(dir):
    global size_table
    global it
    size_table[dir] = 0
    ans = 0
    for line in it:
        line = line.strip()
        if line[0].isdigit():
            size_table[dir] += int(line.split()[0])
            continue
        if line.startswith("dir") or line.startswith("$ l"):
            continue
        rel = line.split()[2]
        if rel == "..":
            return ans + (size_table[dir] if size_table[dir] <= max_size else 0)
        newdir = dir + "/" + rel
        if newdir in size_table.keys():
            size_table[dir] += size_table[newdir]
            continue
        ans += dfs(newdir)
        size_table[dir] += size_table[newdir]
    return ans + (size_table[dir] if size_table[dir] <= max_size else 0)


print(dfs(""))
print(min(x for x in size_table.values() if x >= size_table[""] - max_used))
