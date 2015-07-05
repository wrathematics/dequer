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
  if (class(x) != "deque") stop("'x' must be a deque.")
  
  .Call("R_deque_pop", x)
  invisible()
}
