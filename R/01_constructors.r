#' queue
#' 
#' A constructor for a queue.
#' 
#' @description
#' A queue is a "first in, first out" abstract data type.  Like a checkout
#' queue (line) at a store, the first item in the queue is the first
#' one out. New items are added to the end of the queue via \code{pushback()}.
#' Items are removed from the queue at the front via \code{pop()}.
#' 
#' The implementation is a head/tail doubly linked list.
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



#' stack
#' 
#' A constructor for a stack.
#' 
#' @description
#' A stack is a "last in, first out" (LIFO) abstract data type. New items are
#' added to the front of the stack via \code{push()}. Items are removed from
#' the stack at the front via \code{pop()}.
#' 
#' The implementation is a head/tail doubly linked list.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' s <- stack()
#' s
#' }
#' 
#' @export
stack <- function()
{
  ret <- .Call(R_deque_create)
  class(ret) <- "stack"
  
  ret
}



#' deque
#' 
#' A constructor for a deque.
#' 
#' @details
#' A deque is a double-ended queue.  Insertion and deletion of
#' objects can happen at either end.
#' 
#' The implementation is a head/tail doubly linked list.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' d <- deque()
#' d
#' }
#' 
#' @export
deque <- function()
{
  ret <- .Call(R_deque_create)
  class(ret) <- "deque"
  
  ret
}
