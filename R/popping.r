#' pop/popback
#' 
#' Remove items from the front of a deque/stack for \code{pop()}; or, 
#' remove items from the back of a deque/stack for \code{popback()}.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque or a stack for \code{pop()}. A deque or queue for \code{popback()}.
#' 
#' @return
#' Returns \code{NULL}; deletion operates via side-effects.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' pushback(d, 1)
#' pushback(d, 2)
#' pushback(d, 3)
#' 
#' pop(d)
#' print(d, output="full")
#' 
#' popback(d)
#' print(d, output="full")
#' 
#' @name popping
#' @rdname popping
NULL

#' @rdname popping
#' @export
pop <- function(x) UseMethod("pop")

popper <- function(x)
{
  .Call("R_deque_pop", x)
  invisible()
}

#' @rdname popping
#' @export
pop.deque <- popper

#' @rdname popping
#' @export
pop.stack <- popper



#' @rdname popping
#' @export
popback <- function(x) UseMethod("popback")

popperback <- function(x)
{
  .Call("R_deque_popback", x)
  invisible()
}

#' @rdname popping
#' @export
popback.deque <- popperback

#' @rdname popping
#' @export
popback.queue <- popperback
