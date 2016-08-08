suppressPackageStartupMessages(library(dequer))

l <- as.list(1:10)

q <- queue()
for (i in 1:10) pushback(q, i)

s <- stack()
for (i in 10:1) push(s, i)


lq <- as.list(q)
ls <- as.list(s)

stopifnot(all.equal(l, lq))
stopifnot(all.equal(l, ls))

dq <- as.deque(q)
ds <- as.deque(s)

ldq <- as.list(dq)
lds <- as.list(ds)

stopifnot(all.equal(l, ldq))
stopifnot(all.equal(l, lds))
