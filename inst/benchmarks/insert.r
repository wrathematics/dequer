library(dequer)
library(rbenchmark)
cols <- cols <- c("test", "replications", "elapsed", "relative")

reps <- 25
n <- 5e3

cat("-------- pushback --------\n")

f <- function(n)
{
  l <- list()
  for (i in 1:n) l[[i]] <- i
  
  l
}


g <- function(n)
{
  q <- queue()
  for (i in 1:n) pushback(q, i)
  l <- as.list(q)
  
  l
}

benchmark(l1 <- f(n), l2 <- g(n), replications=reps, columns=cols)
all.equal(l1, l2)

invisible(gc())
