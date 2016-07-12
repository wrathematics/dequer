headtail <- function(x, n, headsortails)
{
  n <- as.integer(n)
  
  .Call(R_deque_headsortails, x, n, headsortails)
  invisible()
}

peeker <- function(x, n) headtail(x, n=n, PEEKER_HEADS)
peekbacker <- function(x, n) headtail(x, n=n, PEEKER_TAILS)



#' peek/peekback
#' 
#' View items from the front/back of a deque or a stack, for \code{peek()} or
#' or \code{peekback()}, respectively. Similar to \code{head()} and \code{tail()}.
#' 
#' @description
#' These methods are side-effect free. Note that unlike R's \code{head()} and
#' \code{tail()}, the sub-objects are not actually created. They are merely
#' printed.
#' 
#' @param x
#' A deque or a stack.
#' @param n
#' The number of items to view.
#' 
#' @return
#' Returns \code{NULL}; sub-elements are only printed.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' peek(d)
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
peek.stack <- peekbacker



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
peekback.stack <- peeker
