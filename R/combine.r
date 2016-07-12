#' combine
#' 
#' Combine two deques into one deque.
#' 
#' @details
#' Operates via side-effects; see examples for clarification on usage.
#' 
#' @examples
#' library(dequer)
#' d <- deque()
#' push(d, 1)
#' push(d, 2)
#' popback(d)
#' print(d, output="full")
#' 
#' @param x1,x2
#' Two different deques.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' d1 <- deque()
#' for (i in 1:5) push(d1, i)
#' d2 <- deque()
#' for (i in 10:8) push(d2, i)
#' 
#' combine(d1, d2)
#' }
#' 
#' @export
combine <- function(x1, x2)
{
  if (class(x1) != "deque") stop("'x1' must be a deque.")
  if (class(x2) != "deque") stop("'x2' must be a deque.")
  
  .Call(R_deque_combine, x1, x2)
  invisible()
}
