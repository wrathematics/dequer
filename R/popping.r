#' pop/popback
#' 
#' Remove items from the front of a stack, queue, or deque for \code{pop()}; or, 
#' remove items from the back of a deque for \code{popback()}.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A queue, stack, or deque.
#' 
#' @return
#' Returns \code{NULL}; deletion operates via side-effects.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' 
#' ### A simple queue example
#' q <- queue()
#' for (i in 1:3) pushback(q, i)
#' 
#' pop(q)
#' str(q)
#' 
#' ### A simple stack example
#' s <- stack()
#' for (i in 1:3) push(s, i)
#' pop(s)
#' str(s)
#' }
#' 
#' @name popping
#' @rdname popping
NULL



#' @useDynLib dequer R_deque_pop
#' @useDynLib dequer R_deque_popback
NULL



#' @rdname popping
#' @export
pop <- function(x) UseMethod("pop")

#' @rdname popping
#' @export
pop.deque <- function(x) .Call(R_deque_pop, x)

#' @rdname popping
#' @export
pop.queue <- function(x) .Call(R_deque_popback, x)

#' @rdname popping
#' @export
pop.stack <- function(x) .Call(R_deque_pop, x)



#' @rdname popping
#' @export
popback <- function(x) UseMethod("popback")

#' @rdname popping
#' @export
popback.deque <- function(x) .Call(R_deque_popback, x)
