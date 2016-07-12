#' rev
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque.
#' 
#' @return
#' Returns \code{NULL}; insertion operates via side-effects.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' for (i in 1:5) push(d, i)
#' 
#' print(d, output="full")
#' rev(d)
#' print(d, output="full")
#' 
#' @name rev-deque
#' @rdname rev-deque
#' @method rev deque
#' @export
rev.deque <- function(x)
{
  .Call("R_deque_reverse", x)
  invisible()
}
