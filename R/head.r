#' @export
head.deque <- function(x, n=6, ...)
{
  n <- as.integer(n)
  
  .Call("R_deque_headsortails", x, n, 1L)
  invisible()
}
