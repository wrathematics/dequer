# dequer

Pronounced "decker".

Like a list in R, but the memory isn't contiguous, so insertions are
very cheap:

```r
library(dequer)

n <- 5e4

### Growing an R list is expensive
system.time({
  l <- list()
  for (i in 1:n) l[[i]] <- i
})
#    user  system elapsed 
#   7.220   0.000   7.214 


### Growing a deque is very cheap
system.time({
  dl <- deque()
  for (i in 1:n) pushback(dl, i)
  l2 <- as.list(dl)
})
#    user  system elapsed 
#   0.192   0.000   0.192 


all.equal(l, l2)
# [1] TRUE
```



## Known Issues

* The pops currently leak.
* `gc()` pretty much DDoS's your R session, seemingly from the 
  `R_ReleaseObject()` calls.  Dunno what the deal is.



## Installationn

```r
devtools::install_github("wrathematics/dequer")
```


