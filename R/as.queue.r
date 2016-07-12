#' Convert to Queue
#' 
#' @param x
#' An object either to be converted to the first element of a queue
#' (default), or the elements of a list (or columns of a dataframe)
#' to be set as elements of a queue.
#'
#' @return
#' A queue object.
#' 
#' @examples
#' \dontrun{
#' library(dequer)
#' q <- as.queue(lapply(1:5, identity))
#' q
#' }
#' 
#' @export
#' @name as.queue
#' @rdname as.queue
as.queue <- function(x) UseMethod("as.queue")

#' @export
#' @rdname as.queue
as.queue.list <- function(x)
{
  q <- queue()
  
  for (obj in x)
    pushback(q, obj)
  
  return(q)
}

#' @export
#' @rdname as.queue
as.queue.default <- function(x)
{
  q <- queue()
  pushback(q, x)
  
  return(q)
}

#' @export
#' @rdname as.queue
as.queue.deque <- function(x)
{
  class(x) <- "queue"
  return(x)
}

#' @export
#' @rdname as.queue
as.queue.stack <- function(x)
{
  class(x) <- "queue"
  rev.deque(x)
  return(x)
}
