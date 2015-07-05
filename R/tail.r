tailer <- function(x, n=6, ...)
{
  n <- as.integer(n)
  
  .Call("R_deque_headsortails", x, n, 2L)
  invisible()
}



#' @export
tail.deque <- tailer

#' @export
tail.queue <- tailer

#' @export
tail.stack <- tailer
