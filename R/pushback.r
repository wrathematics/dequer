#' pushback
#' 
#' Add items to the back of a deque or a queue.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque or a queue.
#' @param data
#' R object to insert at the back of a deque/queue.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' pushback(d, 1)
#' pushback(d, 2)
#' print(d, output="full")
#' 
#' @name pushback
#' @rdname pushback
#' @export
pushback <- function(x, data) UseMethod("pushback")

pusherback <- function(x, data)
{
  .Call("R_deque_pushback", x, data)
  invisible()
}

#' @rdname pushback
#' @export
pushback.deque <- pusherback

#' @rdname pushback
#' @export
pushback.queue <- pusherback
