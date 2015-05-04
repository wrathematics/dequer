# dequer

Pronounced "decker".

Like a list in R, but the memory isn't contiguous, so insertions are
very cheap:

```r
library(dequer)

n <- 2e5

### Growing an R list is expensive
system.time({
  l <- list()
  for (i in 1:n) l[[i]] <- i
})
#    user  system elapsed 
# 142.463   0.079 142.364 


### Growing a deque is very cheap
system.time({
  dl <- deque()
  for (i in 1:n) pushback(dl, i)
  l2 <- as.list(dl)
})
#    user  system elapsed 
#   0.906   0.008   0.913 


all.equal(l, l2)
# [1] TRUE
```



## Known Issues

* Not so much a bug as a side-effect of using this kind of data
structure, but it's somewhat unintuitive (and at first I thought it
was a bug).  So this is worth mentioning.  If you create a deque
by pushbacks, you need to call `rev(mydeque)` when you're done with
it.  Otherwise, when R goes to free the object (calling `rm();gc()`
or exiting R), you will have to wait an inordinate time for R to
traverse the deque and free the R objects (essentially in the wrong
order).  The basic reason is that the preserve/release of R objects
[is implemented as a stack](http://lists.r-forge.r-project.org/pipermail/rcpp-devel/2010-January/000180.html),
and so if you do this in the wrong order, performance tanks.
The bright side is, `rev()` is very cheap.



## Operations

At this time, `deque` objects support:

* `as.list()`
* `push()`, `pushback()`, `pop()`, and `popback()`
* `rev()`
* `length()`
* `head()` and `tail()`
* `str()` and special `print()`-ing
* `combine()` and `split()`



## Notes

Insertion/deletion with the deque is done via pushes/pops.  This is
very un-parallel safe.  



## Installationn

```r
devtools::install_github("wrathematics/dequer")
```


