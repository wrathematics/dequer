#' popback
#' 
#' Remove items from the back of a deque or a queue.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @param x
#' A deque or a queue.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' popback(d)
#' print(d, output="full")
#' 
#' @name popback
#' @rdname popback
#' @export
popback <- function(x) UseMethod("popback")

popperback <- function(x)
{
  .Call("R_deque_popback", x)
  invisible()
}

#' @rdname popback
#' @export
popback.deque <- popperback

#' @rdname popback
#' @export
popback.queue <- popperback
