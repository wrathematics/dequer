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
  if (class(x) != "deque") stop("'x' must be a deque.")
  
  .Call("R_deque_push", x, data)
  invisible()
}
