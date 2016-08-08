#' rev
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A queue, stack, or deque.
#' 
#' @return
#' Returns \code{NULL}; insertion operates via side-effects.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' s <- stack()
#' for (i in 1:5) push(d, i)
#' 
#' str(s)
#' rev(s)
#' str(s)
#' }
#' 
#' @name revver
#' @rdname revver
#' @method rev deque
#' @method rev stack
#' @method rev queue
NULL

revver <- function(x)
{
  .Call(R_deque_reverse, x)
  invisible()
}

#' @rdname revver
#' @export
rev.deque <- revver

#' @rdname revver
#' @export
rev.stack <- revver

#' @rdname revver
#' @export
rev.queue <- revver
