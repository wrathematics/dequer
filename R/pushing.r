#' push/pushback
#' 
#' Add items to the front of a deque/stack for \code{pop()}; or, 
#' add items to the back of a deque/stack for \code{popback()}.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque or a stack for \code{push()}. A deque or queue for \code{push()}.
#' @param data
#' R object to insert at the front of the deque/stack.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' pushback(d, 1)
#' pushback(d, 2)
#' print(d, output="full")
#' 
#' push(d, 3)
#' print(d, output="full")
#' 
#' @name pushing
#' @rdname pushing
NULL

#' @rdname pushing
#' @export
push <- function(x, data) UseMethod("push")

pusher <- function(x, data)
{
  .Call("R_deque_push", x, data)
  invisible()
}

#' @rdname pushing
#' @export
push.deque <- pusher

#' @rdname pushing
#' @export
push.stack <- pusher



#' @rdname pushing
#' @export
pushback <- function(x, data) UseMethod("pushback")

pusherback <- function(x, data)
{
  .Call("R_deque_pushback", x, data)
  invisible()
}

#' @rdname pushing
#' @export
pushback.deque <- pusherback

#' @rdname pushing
#' @export
pushback.queue <- pusherback
