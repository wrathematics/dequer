#' push/pushback
#' 
#' Add items to the front of a stack or deque via \code{pop()}.  
#' Add items to the back of a queue or deque via \code{popback()}.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A queue, stack, or deque.
#' @param data
#' R object to insert at the front of the deque/stack.
#' 
#' @return
#' Returns \code{NULL}; insertion operates via side-effects.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' 
#' ### A simple queue example
#' q <- queue()
#' for (i in 1:3) pushback(q, i)
#' 
#' str(q)
#' 
#' ### A simple stack example
#' s <- stack()
#' for (i in 1:3) push(s, i)
#' 
#' str(s)
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
pushback.queue <- function(x, data) invisible(.Call(R_deque_push, x, data))
