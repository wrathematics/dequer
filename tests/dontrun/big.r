### Checking for memory leaks
suppressPackageStartupMessages(library(dequer))

n <- 1e5

l1 <- lapply(1:n, identity)

system.time({
  d <- deque()
  for (i in n:1) push(d, i)
  l2 <- as.list(d)
})
stopifnot(identical(l1, l2))
rm(d, l2)
invisible(gc())


system.time({
  q = queue()
  for (i in 1:n) pushback(q, i)
  l2 <- as.list(q)
})
stopifnot(identical(l1, l2))
rm(q, l2)
invisible(gc())


system.time({
  s = dequer::stack()
  for (i in n:1) push(s, i)
  l2 <- as.list(s)
})
stopifnot(identical(l1, l2))
rm(s, l2)
invisible(gc())
