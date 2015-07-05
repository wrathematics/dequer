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
  if (class(x) != "deque") stop("'x' must be a deque.")
  
  .Call("R_deque_popback", x)
  invisible()
}
