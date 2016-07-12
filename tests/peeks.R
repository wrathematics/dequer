suppressPackageStartupMessages(library(dequer))

d <- deque()

for (i in 1:2) pushback(d, i)

test <- capture.output(peek(d))
truth <- c("[[1]]", "[1] 1", "")
stopifnot(all.equal(test, truth))

test <- capture.output(peekback(d))
truth <- c("[[1]]", "[1] 2", "")
stopifnot(all.equal(test, truth))
