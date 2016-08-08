headtail <- function(x, n, headsortails)
{
  n <- as.integer(n)
  
  .Call(R_deque_headsortails, x, n, headsortails)
  invisible()
}

peeker <- function(x, n=1L) headtail(x, n=n, PEEKER_HEADS)
peekbacker <- function(x, n=1L) headtail(x, n=n, PEEKER_TAILS)



#' peek/peekback
#' 
#' View items from the front (\code{peek()}) or back (\code{peekback()}) of a
#' queue, stack, or deque.
#' 
#' @description
#' These methods are side-effect free. Note that unlike R's \code{head()} and
#' \code{tail()}, the sub-objects are not actually created. They are merely
#' printed to the terminal.
#' 
#' @param x
#' A queue, stack, or deque.
#' @param n
#' The number of items to view.
#' 
#' @return
#' Returns \code{NULL}; sub-elements are only printed.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' s <- stack()
#' for (i in 1:3) push(s, i)
#' 
#' peek(s)
#' peekback(s)
#' peek(s, length(s))
#' }
#' 
#' @name peeking
#' @rdname peeking
NULL



#' @rdname peeking
#' @export
peek <- function(x, n=1L) UseMethod("peek")

#' @rdname peeking
#' @export
peek.deque <- peeker

#' @rdname peeking
#' @export
peek.queue <- peekbacker

#' @rdname peeking
#' @export
peek.stack <- peeker



#' @rdname peeking
#' @export
peekback <- function(x, n=1L) UseMethod("peekback")

#' @rdname peeking
#' @export
peekback.deque <- peekbacker

#' @rdname peeking
#' @export
peekback.queue <- peeker

#' @rdname peeking
#' @export
peekback.stack <- peekbacker
