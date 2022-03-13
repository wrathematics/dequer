#' Convert to Deque
#' 
#' @param x
#' An object either to be converted to the first element of a deque
#' (default), or the elements of a list (or columns of a dataframe)
#' to be set as elements of a deque.
#'
#' @return
#' A queue, stack, or deque.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' d <- as.deque(lapply(1:5, identity))
#' d
#' }
#' 
#' @name as.deque
#' @rdname as.deque
#' @export
as.deque <- function(x) UseMethod("as.deque")



#' @export
#' @rdname as.deque
as.deque.list <- function(x)
{
  d <- deque()
  
  for (obj in x)
    push(d, obj)
  
  rev(d)
  
  return(d)
}



#' @export
#' @rdname as.deque
as.deque.default <- function(x)
{
  d <- deque()
  push(d, x)
  
  return(d)
}



#' @export
#' @rdname as.deque
as.deque.queue <- function(x)
{
  rev(x)
  class(x) <- "deque"
  return(x)
}



#' @export
#' @rdname as.deque
as.deque.stack <- function(x)
{
  class(x) <- "deque"
  return(x)
}
