#' deque
#' 
#' An initializer for a deque.
#' 
#' A deque is a double-ended queue.  Insertion and deletion of
#' objects can happen at either end.
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
