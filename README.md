# dequer 

* **Version:** 1.1-0
* **Status:** [![Build Status](https://travis-ci.org/wrathematics/dequer.png)](https://travis-ci.org/wrathematics/dequer) 
* **License:** [![License](http://img.shields.io/badge/license-BSD%202--Clause-orange.svg?style=flat)](http://opensource.org/licenses/BSD-2-Clause)
* **Author:** Drew Schmidt


This package offers three new data structures for R: the stack, queue, and dequue (double ended queue).  These are somewhat similar to R's lists in that they are "linear" (vector-like) and can store arbitrary objects.  However, they are much cheaper to "grow" than R's lists, as the underlying data is not required to be contiguously stored.

The canonical use case is when you need to store data, and you don't know how much of it you ultimately need to store (and thus can not pre-allocate a list).

Note that unless truly necessary, we do not recommend using deques.  Stacks and queues are perfectly safe, but due to how memory is managed in R, deques can result in terrible performance depending on how they are used; this usually manifests itself when the object is deleted and the garbage collector runs.  See the issues section below for full details.

The package is pronounced like "decker".





## Installation

To install the R package, run:

```r
install.package("dequer")
```

The development version is maintained on GitHub, and can easily be installed by any of the packages that offer installations from GitHub:

```r
### Pick your preference
devtools::install_github("wrathematics/dequer")
ghit::install_github("wrathematics/dequer")
remotes::install_github("wrathematics/dequer")
```





## Quick Example Usage

If you need to create a list and do not know how many elements the final object should have, it is better to use a queue or a stack (or if you're careful, a deque) to store the data before casting to a native R list object, with rough pseudocode:

```r
### Initialize
q <- queue()

### Insert
while (TRUE)
{
  new_object <- getNewObject()
  # put 'new_object' at the end of the queue; like calling `myList[[i]] <- new_object`
  pushback(q, new_object)
  
  condition <- checkCondition(criteria)
  if (condition) break
}

### Convert queue to an R list
l <- as.list(q)
```

If you know how long the final object should be, it is a significantly better idea to just preallocate a list, or use an `lapply()`:

```r
### Preallocate
l <- vector("list", big_num)
for (i in 1:big_num) l[[i]] <- i

### lapply()
l <- lapply(1:big_num, identity)
```





## Queues vs Stacks

tl;dr: If you just want a replacement for an R list, use a queue.

A queue is like a line (America) or queue (Britland) at a store.  The first one in is the first one out, or FIFO.  So too with the data structure, the first object in is the first one back out.  In code, we would do this first by creating a placeholder for the queue:

```r
library(dequer)
q <- queue()
```

We can then "fill the line" by filling it from the back (just like how lines work at the store)

```r
for (i in 1:3) pushback(q, i)
str(q)
## queue of 3
##  $ : int 1
##  $ : int 2
##  $ : int 3
```

We can start emptying the queue by "popping" whatever's in first:

```r
pop(q)
str(q)
## queue of 2
##  $ : int 2
##  $ : int 3

pop(q)
str(q)
## queue of 1
##  $ : int 3
pop(q)
str(q)
## queue()
```

On the other hand, a stack is a last in, first out, or LIFO structure.  It's like a really unfair line, or like how traffic works only for you personally.  So we can't `pop()` elements on a stack, but we can `popback()` them, or pop them off the back.

```r
s <- stack()
for (i in 1:3) pushback(s, i)
str(s)
## stack of 3
##  $ : int 1
##  $ : int 2
##  $ : int 3

popback(s)
str(s)
## stack of 2
##  $ : int 1
##  $ : int 2
```

Once the queue or stack has served its purpose, you will probably want to operate on the data stored in them.  To do so, convert to a list with `as.list()`:

```r
as.list(s)
## [[1]]
## [1] 1
## 
## [[2]]
## [1] 2

### since q is empty, this is equivalent to calling `list()`
as.list(q)
## list()
```





## Detailed Example and Discussion

Consider the following example:

```r
library(dequer)

n <- 2e5

### Growing an R list is expensive
system.time({
  l1 <- list()
  for (i in 1:n)
    l1[[i]] <- i
})
##    user  system elapsed 
## 167.196   5.048 172.270 


### Growing a queue is very cheap
system.time({
  q <- queue()
  for (i in 1:n)
    pushback(q, i)
  
  l2 <- as.list(q)
})
##  user  system elapsed 
## 0.596   0.012   0.606 


identical(l1, l2)
# [1] TRUE
```

In reality, we could just preallocate our list because we know how many elements the final object should have.  And if you *do* know how many elements the final object should have, that is *exactly* what you should do.  In such a case, you should do something like:

```r
system.time({
  l1 <- vector(mode="list", length=n)
  for (i in 1:n)
    l1[[i]] <- i
})
##  user  system elapsed 
## 0.188   0.000   0.191 
```

Or in this *particular* case, you could even more simply do:

```r
system.time({
  l1 <- as.list(1:n)
})
##    user  system elapsed 
##   0.004   0.000   0.005 
```

But for the cases where we don't, this example shows why it's a better strategy to use these new data structures.  The reason the list version is so slow is because at each iteration of the loop, R will:

1. Allocate new storage for a list of length `length(l)+1`.
2. Copy over the first `length(l)` items from `l` to the new storage.
3. Fill the last element of the new storage with the new item.
4. Replace the object pointed to by `l` to the new storage.
5. Mark the old storage for deletion by the garbage collector.

All of these unnecessary memory operations are very expensive if you need to do a lot of them. Using an approach like the one above will achieve much better performance.





## Operations

At this time, stacks objects support:

| Operation | queue | stack | deque |
| --------- | ----- | ----- | ----- |
| `as.list()` | ✓ | ✓ | ✓ | 

* `as.list()`
* `push()`, `pushback()`, `pop()`, and `popback()`
* `rev()`
* `length()`
* `head()` and `tail()`
* `str()` and special `print()`-ing
* `combine()` and `split()`

Unlike probably everything you've ever used with R, most of these functions operate by side-effects.  For example, say you want to reverse the deque.  With normal R things, you would call:

```r
reversed_object <- rev(object)
```

This creates a copy of the memory stored in `object`, just reversed. For an object that is inherently meant to be temporary, like the deque, this is needlessly costly.  Instead, we would call:

```r
rev(d) ### d is a deque
```

In this case, `rev()` will return `NULL`, but the object is still reversed.  Observe:

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

It is not only faster to perform the reverse without making a copy (just rearranging some pointers), but we don't have to carry around a bunch of memory we no longer care about.

Most deque functions operate by side-effects (it should be clear from the previous example that `pushback()` does as well).  The deque operations that don't have side-effects are:

* `as.list()` (returns a list)
* `length()` (returns an integer)
* `head()` and `tail()` (return a list, or `NULL` if just printing)
* `str()` and `print()` (return `NULL`)



## Notes and Known Issues

* It should go without saying that the functions with side-effects are very un-parallel safe.

* Not so much a bug as a side-effect of using this kind of data structure, but it's somewhat unintuitive (and at first I thought it was a bug).  So this is worth mentioning.  If you create a deque by pushbacks, you need to call `rev(mydeque)` when you're done with it.  Otherwise, when R goes to free the object (calling `rm();gc()` or exiting R), you will have to wait an inordinate time for R to traverse the deque and free the R objects (essentially in the wrong order).  The basic reason is that the preserve/release of R objects [is implemented as a stack](http://lists.r-forge.r-project.org/pipermail/rcpp-devel/2010-January/000180.html), and so if you do this in the wrong order, performance tanks. The bright side is, `rev()` is very cheap.
