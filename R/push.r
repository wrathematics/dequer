#' push
#' 
#' Add items to the front of a deque or a stack.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque or a stack.
#' @param data
#' R object to insert at the front of the deque/stack.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' print(d, output="full")
#' 
#' @name push
#' @rdname push
#' @export
push <- function(x, data) UseMethod("push")

pusher <- function(x, data)
{
  .Call("R_deque_push", x, data)
  invisible()
}

#' @rdname push
#' @export
push.deque <- pusher

#' @rdname push
#' @export
push.stack <- pusher
