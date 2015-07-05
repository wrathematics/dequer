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
  if (class(x) != "deque") stop("'x' must be a deque.")
  
  .Call("R_deque_pushback", x, data)
  invisible()
}
