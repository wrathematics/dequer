#' queue
#' 
#' An initializer for a queue.
#' 
#' @description
#' A queue is a "first in, first out" data structure.  Like a checkout
#' queue (line) at a store, the first one in the queue is the first
#' one out.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' q <- queue()
#' q
#' }
#' 
#' @export
queue <- function()
{
  ret <- .Call(R_deque_create)
  class(ret) <- "queue"
  
  ret
}
