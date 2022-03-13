#' sep
#' 
#' Spliot one object (queue/stack/deque) into two of the same type. NOTE: this
#' function operates via side-effects AND has a return.
#' 
#' @details
#' Operates via side-effects ALTHOUGH THERE IS A NON-NULL RETURN; see examples
#' for clarification on usage.
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
#' @return
#' A deque, stack, or queue (depending on the input)
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' s <- stack()
#' for (i in 1:5) push(s, i)
#' 
#' ### Split s into 2 stacks holding: (s) the first 3, and (s_last_2) last 2 elements
#' s_last_2 <- sep(s, 3)
#' 
#' str(s)
#' str(s_last_5)
#' }
#' 
#' @useDynLib dequer R_deque_split
#' @export
sep <- function(x, k)
{
  if (!(class(x) %in% CLASSES))
    stop("'x' must be a deque, stack, or queue.")
  if (!is.numeric(k) || abs(k-round(k)) > 1e-12 || k < 1)
    stop("'k' must be a positive integer")
  
  if (k >= length(x))
    stop("'k' must be less than length(x)")
  
  ret <- .Call(R_deque_split, x, as.integer(k))
  class(ret) <- class(x)
  
  ret
}
