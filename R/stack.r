#' stack
#' 
#' An initializer for a stack.
#' 
#' @description
#' A stack is a "last in, first out" data structure.
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
