# dequer 

* **Version:** 2.0-1
* **Status:** [![Build Status](https://travis-ci.org/wrathematics/dequer.png)](https://travis-ci.org/wrathematics/dequer) 
* **License:** [![License](http://img.shields.io/badge/license-BSD%202--Clause-orange.svg?style=flat)](http://opensource.org/licenses/BSD-2-Clause)
* **Author:** Drew Schmidt


This package (pronounced like "decker") offers three new data structures for R: the queue, stack, and dequue (double ended queue).  These are somewhat similar to R's lists in that they are "linear" (vector-like) and can store arbitrary objects.  However, they are much cheaper to "grow" than R's lists, as the underlying data is not required to be contiguously stored.

The canonical use case for these is when you need to store data, and you don't know how much of it you ultimately need to store (and thus can not pre-allocate a list).

Note that unless truly necessary, we do not recommend using deques.  Stacks and queues are perfectly safe, but due to how memory is managed in R, deques can result in terrible performance depending on how they are used; this usually manifests itself when the object is deleted and the garbage collector runs.  See the issues section below for full details.





## Installation

To install the R package, run:

```r
install.packages("dequer")
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
## [1] 1
str(q)
## queue of 2
##  $ : int 2
##  $ : int 3

pop(q)
## [1] 2
str(q)
## queue of 1
##  $ : int 3

pop(q)
## [1] 3
str(q)
## queue()
```

On the other hand, a stack is a last in, first out, or LIFO structure.  It's like a really unfair line, or like how traffic works only for you personally. You still take items off the front with `pop()`, but you add new ones to the front as well via `push()`.

```r
s <- stack()
for (i in 1:3) push(s, i)
str(s)
## stack of 3
##  $ : int 3
##  $ : int 2
##  $ : int 1

pop(s)
## [1] 3
str(s)
## stack of 2
##  $ : int 2
##  $ : int 1
```

Once the queue or stack has served its purpose, you will probably want to operate on the data stored in them.  To do so, convert to a list with `as.list()`:

```r
as.list(s)
## [[1]]
## [1] 2
## 
## [[2]]
## [1] 1

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

The supported operations for each object are:

| Operation | queue | stack | deque |
| --------- | ----- | ----- | ----- |
| `as.list()` | <font color="green">Yes</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 
| `length()` | <font color="green">Yes</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 
| `peek()` | <font color="green">Yes</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 
| `peekback()` | <font color="green">Yes</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 
| `pop()` | <font color="green">Yes</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 
| `popback()` | <font color="red">No</font> | <font color="red">No</font> | <font color="green">Yes</font> | 
| `push()` | <font color="red">No</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 
| `pushback()` | <font color="green">Yes</font> | <font color="red">No</font> | <font color="green">Yes</font> | 
| `str()` | <font color="green">Yes</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 

There are also several "advanced" operations, which could lead to performance loss during garbage collection (see the issues section for more details):

| Operation | queue | stack | deque |
| --------- | ----- | ----- | ----- |
| `combine()` | <font color="green">Yes</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 
| `rev()` | <font color="green">Yes</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 
| `sep()` | <font color="green">Yes</font> | <font color="green">Yes</font> | <font color="green">Yes</font> | 


Unlike most R functions, all these operations operate via side-effects.  For example, to reverse a list, you might do something like

```r
l.rev <- rev(l)
```

This creates a new copy of the list, only with items in reverse.  For **dequer** package objects, you would just call:

```r
rev(object) # 'object' is a queue, stack, or deque
```

The function execution will actually return `NULL`; the object itself has been reversed without making any copies.  Observe:

```r
library(dequer)
q <- queue()
for (i in 1:3) pushback(q, i)
str(q)
## queue of 3
##  $ : int 1
##  $ : int 2
##  $ : int 3

rev(q)
str(q)
## queue of 3
##  $ : int 3
##  $ : int 2
##  $ : int 1
```





## Notes and Known Issues

* It should go without saying that the functions with side-effects are very un-parallel safe.

* If you create a deque by pushbacks, you need to call `rev()` on it when you're done with it.  Otherwise, when R goes to free the object (calling `rm();gc()` or exiting R), you will have to wait an inordinate time for R to traverse the deque and free the R objects (essentially in the wrong order).  The basic reason is that the preserve/release of R objects [is implemented as a stack](http://lists.r-forge.r-project.org/pipermail/rcpp-devel/2010-January/000180.html), and so if you do this in the wrong order, performance tanks. The bright side is, `rev()` is very cheap, or you can just use stacks and queues without any penalty.
