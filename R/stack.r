#' stack
#' 
#' An initializer for a stack.
#' 
#' A stack is a "last in, first out" data structure.
#' 
#' @examples
#' library(dequer)
#' s <- stack()
#' s
#' 
#' @export
stack <- function()
{
  ret <- .Call("R_deque_create")
  class(ret) <- "stack"
  
  ret
}
