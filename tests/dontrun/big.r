### Checking for memory leaks
suppressPackageStartupMessages(library(dequer))

n <- 1e5

l1 <- lapply(n:1, identity)

system.time({
  dl <- deque()
  for (i in 1:n) push(dl, i)
  l2 <- as.list(dl)
})
stopifnot(identical(l1, l2))
rm(dl, l2)
invisible(gc())


system.time({
  q = queue()
  for (i in n:1) pushback(q, i)
  l2 <- as.list(q)
})
stopifnot(identical(l1, l2))
rm(q, l2)
invisible(gc())


system.time({
  s = dequer::stack()
  for (i in n:1) pushback(s, i)
  l2 <- as.list(s)
})
stopifnot(identical(l1, l2))
rm(s, l2)
invisible(gc())
