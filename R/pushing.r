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
#' @return
#' Returns \code{NULL}; insertion operates via side-effects.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' d <- deque()
#' pushback(d, 1)
#' pushback(d, 2)
#' print(d, output="full")
#' 
#' push(d, 3)
#' print(d, output="full")
#' }
#' 
#' @name pushing
#' @rdname pushing
NULL

#' @rdname pushing
#' @export
push <- function(x, data) UseMethod("push")

#' @rdname pushing
#' @export
push.deque <- function(x, data) invisible(.Call(R_deque_push, x, data))

#' @rdname pushing
#' @export
push.stack <- function(x, data) invisible(.Call(R_deque_push, x, data))



#' @rdname pushing
#' @export
pushback <- function(x, data) UseMethod("pushback")

#' @rdname pushing
#' @export
pushback.deque <- function(x, data) invisible(.Call(R_deque_pushback, x, data))

#' @rdname pushing
#' @export
pushback.queue <- function(x, data) invisible(.Call(R_deque_pushback, x, data))
