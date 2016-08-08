#' combine
#' 
#' Combine two objects (queue/stack/deque) into one of the same type.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x1,x2
#' Two different deques, stacks, or queues. Arguments must be of the same type.
#' 
#' @return
#' Returns \code{NULL}. After combining, object \code{x2} is a 0-length (empty)
#' object.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' s1 <- stack()
#' for (i in 1:5) push(s1, i)
#' s2 <- stack()
#' for (i in 10:8) push(s2, i)
#' 
#' combine(s1, s2)
#' s1 # now holds all 8 elements
#' s2 # holds 0 elements
#' }
#' 
#' @export
combine <- function(x1, x2)
{
  if (!(class(x1) %in% CLASSES))
    stop("'x1' must be a deque, stack, or queue.")
  if (!(class(x2) %in% CLASSES))
    stop("'x2' must be a deque, stack, or queue.")
  if (class(x1) != class(x2))
    stop("'x1' and 'x2' must be the same class")
  
  .Call(R_deque_combine, x1, x2)
  invisible()
}
