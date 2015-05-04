#' deque
#' 
#' An initializer for a deque.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' d
#' 
#' @export
deque <- function()
{
  ret <- .Call("R_deque_create")
  class(ret) <- "deque"
  
  ret
}


#' push
#' 
#' Add items to the front of a deque.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque.
#' @param data
#' R object to insert into the deque.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' print(d, output="full")
#' 
#' @export
push <- function(x, data)
{
  .Call("R_deque_push", x, data)
  invisible()
}



#' pushback
#' 
#' Add items to the back of a deque.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque.
#' @param data
#' R object to insert into the deque.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' pushback(d, 1)
#' pushback(d, 2)
#' print(d, output="full")
#' 
#' @export
pushback <- function(x, data)
{
  .Call("R_deque_pushback", x, data)
  invisible()
}



#' pop
#' 
#' Remove items from the front of a deque.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' pop(d)
#' print(d, output="full")
#' 
#' @export
pop <- function(x)
{
  .Call("R_deque_pop", x)
  invisible()
}



#' popback
#' 
#' Remove items from the back of a deque.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' popback(d)
#' print(d, output="full")
#' 
#' @export
popback <- function(x)
{
  .Call("R_deque_popback", x)
  invisible()
}



#' sep
#' 
#' Split one deque into two deques.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' The split occurs after index k.  So if the input x has, say,
#' elements 1 to n, then after running \code{sep(x, k)}, x will
#' have elements 1 to k, and the return will have values
#' k+1, k+2, ..., n.
#' 
#' @param x
#' A deque.
#' @param k
#' Index to split the deque at.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' for (i in 1:5) push(d, i)
#' 
#' d_new <- sep(d, 3)
#' 
#' print(d, output="full")
#' print(d_new, output="full")
#' 
#' @export
sep <- function(x, k)
{
  k <- as.integer(k)
  
  if (k > length(x))
    stop("")
  if (k < 0)
    stop("")
  
  ret <- .Call("R_deque_split", x, k)
  class(ret) <- "deque"
  
  ret
}



#' combine
#' 
#' Combine two deques into one deque.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' popback(d)
#' print(d, output="full")
#' 
#' @param x1,x2
#' Two different deques.
#' 
#' @examples
#' library(dequer)
#' d1 <- deque()
#' for (i in 1:5) push(d1, i)
#' d2 <- deque()
#' for (i in 10:8) push(d2, i)
#' 
#' combine(d1, d2)
#' 
#' @export
combine <- function(x1, x2)
{
  .Call("R_deque_combine", x1, x2)
  invisible()
}

