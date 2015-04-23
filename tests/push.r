library(dequer)

n <- 1e4

dl <- deque()
for (i in 1:n) push(dl, i)

rm(dl)
gc()
