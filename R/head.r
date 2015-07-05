header <- function(x, n=6, ...)
{
  n <- as.integer(n)
  
  .Call("R_deque_headsortails", x, n, 1L)
  invisible()
}



#' @export
head.deque <- header

#' @export
head.queue <- header

#' @export
head.stack <- header
