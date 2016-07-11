#' pop
#' 
#' Remove items from the front of a deque or a stack.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque or a stack.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' pop(d)
#' print(d, output="full")
#' 
#' @name pop
#' @rdname pop
#' @export
pop <- function(x) UseMethod("pop")

popper <- function(x)
{
  .Call("R_deque_pop", x)
  invisible()
}

#' @rdname pop
#' @export
pop.deque <- popper

#' @rdname pop
#' @export
pop.stack <- popper
