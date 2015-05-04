library(dequer)

n <- 3
m <- 4

dl1 <- deque()
for (i in 1:n) push(dl1, i)
for (i in 1:m) pushback(dl1, i)

dl2 <- sep(dl1, 3)


l1 <- as.list(dl1)
l2 <- as.list(dl2)

truth1 <- list(3, 2, 1)
truth2 <- list(1, 2, 3, 4)

stopifnot(all.equal(l1, truth1))
stopifnot(all.equal(l2, truth2))

invisible({rm(dl1, dl2);gc()})
