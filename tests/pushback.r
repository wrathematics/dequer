library(dequer)

n <- 1e4

dl <- deque()
for (i in 1:n) pushback(dl, i)

#head(dl)
#rev(dl)
#head(dl)

rm(dl)
gc()
