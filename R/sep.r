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
#' \dontrun{
#' library(dequer)
#' d <- deque()
#' for (i in 1:5) push(d, i)
#' 
#' d_new <- sep(d, 3)
#' 
#' print(d, output="full")
#' print(d_new, output="full")
#' }
#' 
#' @export
sep <- function(x, k)
{
  if (class(x) != "deque") stop("'x' must be a deque.")
  if (!is.numeric(k) || abs(k-round(k)) > 1e-8 || k < 1)
    stop("'k' must be a positive integer")
  
  if (k > length(x))
    stop("")
  
  ret <- .Call(R_deque_split, x, as.integer(k))
  class(ret) <- "deque"
  
  ret
}
