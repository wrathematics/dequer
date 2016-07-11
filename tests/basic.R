suppressPackageStartupMessages(library(dequer))

d <- deque()
push(d, 1234)
push(d, 897)
pushback(d, "asdf")

stopifnot(length(d) == 3)

l1 <- list(897, 1234, "asdf")
l2 <- as.list(d)

stopifnot(all.equal(l1, l2))
