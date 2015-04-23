### Checking for memory leaks
library(dequer)

n <- 1e5


system.time({
  dl <- deque()
  for (i in 1:n) push(dl, i)
  l2 <- as.list(dl)
})

rm(dl, l2)
invisible(gc())

