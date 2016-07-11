suppressPackageStartupMessages(library(dequer))

dl <- deque()

pushback(dl, 1)
pushback(dl, 2)

test <- capture.output(peek(dl))
truth <- c("[[1]]", "[1] 1", "")
stopifnot(all.equal(test, truth))

test <- capture.output(peekback(dl))
truth <- c("[[1]]", "[1] 2", "")
stopifnot(all.equal(test, truth))
