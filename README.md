# dequer [![Build Status](https://travis-ci.org/wrathematics/dequer.png)](https://travis-ci.org/wrathematics/dequer) [![License](http://img.shields.io/badge/license-BSD%202--Clause-orange.svg?style=flat)](http://opensource.org/licenses/BSD-2-Clause)


Pronounced "decker".

A deque (pronounced like "deck") is a "double ended queue".  This
behaves somewhat like a list in R; but unlike an R list (which is
a contiguous array of pointers), the memory isn't contiguous.
This makes insertions very cheap:

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

The reason the list version is so slow is because at each iteration
of the loop, R will:

1. Allocate new storage for a list of length `length(l)+1`.
2. Copy over the first `length(l)` items from `l` to the new storage.
3. Fill the last element of the new storage with the new item.
4. Replace the object pointed to by `l` to the new storage.
5. Mark the old storage for deletion by the garbage collector.

All of these unnecessary memory operations are very expensive.
Using a deque (or preallocating the list, if possible) is preferable.



## Package Usage

If you need to create a list and do not know how many elements the
final object should have, it is better to use a deque to store
the data before casting to a native R list object, with rough
pseudocode:

```r
### Initialize
d <- deque()

### Insert
while (TRUE)
{
  new_object <- getNewObject()
  # put 'new_object' at the end of the deque; like calling `myList[[i]] <- new_object`
  pushback(d, new_object)
  
  condition <- checkCondition(criteria)
  if (condition) break
}

### Convert to list and free temporary deque storage (see Notes section for more info)
l <- as.list(d)
rev(d);rm(d);gc()
```

If you know how long the final object should be, it is a significantly
better idea to just preallocate a list, or use an `lapply()`:

```r
### Preallocate
l <- vector("list", big_num)
for (i in 1:big_num) l[[i]] <- i

### lapply()
l <- lapply(1:big_num, identity)
```



## Operations

At this time, `deque` objects support:

* `as.list()`
* `push()`, `pushback()`, `pop()`, and `popback()`
* `rev()`
* `length()`
* `head()` and `tail()`
* `str()` and special `print()`-ing
* `combine()` and `split()`

Unlike probably everything you've ever used with R, most of these
functions operate by side-effects.  For example, say you want
to reverse the deque.  With normal R things, you would call:

```r
reversed_object <- rev(object)
```

This creates a copy of the memory stored in `object`, just reversed.
For an object that is inherently meant to be temporary, like the
deque, this is needlessly costly.  Instead, we would call:

```r
rev(d) ### d is a deque object
```

In this case, `rev()` will return `NULL`, but the object is still
reversed.  Observe:

```r
library(dequer)
d <- deque()
for (i in 1:10) pushback(d, i)

d
# [1] "A deque object with 10 elements."

head(d, 2)
# [[1]]
# [1] 1
# 
# [[2]]
# [1] 2

rev(d)

head(d, 2)
# [[1]]
# [1] 10
# 
# [[2]]
# [1] 9
```

It is not only faster to perform the reverse without making a copy
(just rearranging some pointers), but we don't have to carry around
a bunch of memory we no longer care about.

Most deque functions operate by side-effects (it should be clear
from the previous example that `pushback()` does as well).  The
deque operations that don't have side-effects are:

* `as.list()` (returns a list)
* `length()` (returns an integer)
* `head()` and `tail()` (return a list, or `NULL` if just printing)
* `str()` and `print()` (return `NULL`)



## Notes and Known Issues

* Insertion/deletion with the deque is done via pushes/pops.  This is
very un-parallel safe.

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




## Installationn

```r
devtools::install_github("wrathematics/dequer")
```


