HEADS <- 1L
TAILS <- 2L

headtail <- function(x, n, headsortails)
{
  n <- as.integer(n)
  
  .Call("R_deque_headsortails", x, n, headsortails)
  invisible()
}

peeker <- function(x, n) headtail(x, n=1L, HEADS)
peekbacker <- function(x, n) headtail(x, n=1L, TAILS)



#' peek
#' 
#' View items from the front of a deque or a stack. Similar to \code{head()}.
#' 
#' @param x
#' A deque or a stack.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' peek(d)
#' 
#' @name peek
#' @rdname peek
#' @export
peek <- function(x, n=1L) UseMethod("peek")

#' @rdname peek
#' @export
peek.deque <- peeker

#' @rdname peek
#' @export
peek.stack <- peeker



#' peekback
#' 
#' View items from the back of a deque or a queue. Similar to \code{tail()}.
#' 
#' @param x
#' A deque or a queue.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' peekback(d)
#' 
#' @name peekback
#' @rdname peekback
#' @export
peekback <- function(x, n=1L) UseMethod("peekback")


#' @rdname peekback
#' @export
peekback.deque <- peekbacker

#' @rdname peekback
#' @export
peekback.queue <- peekbacker
