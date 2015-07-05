#' deque
#' 
#' An initializer for a deque.
#' 
#' A deque is a double-ended queue.  Insertion and deletion of
#' objects can happen at either end.
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
  if (class(x) != "deque") stop("'x' must be a deque.")
  if (!is.numeric(k) || abs(k-round(k)) > 1e-8 || k < 1)
    stop("'k' must be a positive integer")
  
  if (k > length(x))
    stop("")
  
  ret <- .Call("R_deque_split", x, as.integer(k))
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
  if (class(x1) != "deque") stop("'x1' must be a deque.")
  if (class(x2) != "deque") stop("'x2' must be a deque.")
  
  .Call("R_deque_combine", x1, x2)
  invisible()
}

