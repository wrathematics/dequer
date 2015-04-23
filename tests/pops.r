### Checking for memory leaks
library(dequer)

dl <- deque()

push(dl, 1234)
pop(dl)

push(dl, 1)
push(dl, 2)
pushback(dl, 3)

pop(dl)
popback(dl)

