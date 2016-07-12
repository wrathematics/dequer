#' Convert to Stack
#' 
#' @param x
#' An object either to be converted to the first element of a stack
#' (default), or the elements of a list (or columns of a dataframe)
#' to be set as elements of a stack.
#'
#' @return
#' A stack object.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' s <- as.stack(lapply(1:5, identity))
#' s
#' }
#' 
#' @export
#' @name as.stack
#' @rdname as.stack
as.stack <- function(x) UseMethod("as.stack")



#' @export
#' @rdname as.stack
as.stack.list <- function(x)
{
  s <- stack()
  
  for (obj in x)
    push(s, obj)
  
  return(s)
}



#' @export
#' @rdname as.stack
as.stack.default <- function(x)
{
  s <- stack()
  push(s, x)
  
  return(s)
}



#' @export
#' @rdname as.stack
as.stack.deque <- function(x)
{
  class(x) <- "stack"
  return(x)
}



#' @export
#' @rdname as.stack
as.stack.queue <- function(x)
{
  class(x) <- "queue"
  rev.deque(x)
  return(x)
}
