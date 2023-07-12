#!/usr/bin/env python3

import i3ipc

direction = -1  # -1 left, 1 right

i3 = i3ipc.Connection()
con = i3.get_tree().find_focused()

counter = 0
while con.parent.type != "workspace":
    con = con.parent
    counter += 1

nodes = con.parent.nodes
index = 0

for leaf in nodes:
    if leaf.id == con.id:
        break
    index += 1

index += direction

if index >= len(nodes) or index < 0:
    exit()

con2 = nodes[index]
for _ in range(counter, 0, -1):
    n = con2.nodes
    if len(n) == 0:
        break  # exit()?
    else:
        con2 = n[direction]

con2.command("focus")
