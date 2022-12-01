import strutils
import std/heapqueue

when isMainModule:
  var
    sum = 0
    max_sum = 0
  for line in lines("input/day1.txt"):
    if line == "":
      max_sum = max(sum, max_sum)
      sum = 0
      continue
    sum += line.parseInt
  echo max_sum

  sum = 0
  var maxes = initHeapQueue[int]()
  for line in lines("input/day1.txt"):
    if line == "":
      if maxes.len < 3:
        maxes.push(sum)
      else:
        discard maxes.pushpop(sum)
      sum = 0
      continue
    sum += line.parseInt
  echo maxes[0] + maxes[1] + maxes[2]
