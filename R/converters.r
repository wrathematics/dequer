#' @export
as.list.deque <- function(x, ...)
{
  .Call("R_deque_to_Rlist", x)
}



#' @export
head.deque <- function(x, n=6, ...)
{
  n <- as.integer(n)
  
  .Call("R_deque_headsortails", x, n, 1L)
  invisible()
}



#' @export
tail.deque <- function(x, n=6, ...)
{
  n <- as.integer(n)
  
  .Call("R_deque_headsortails", x, n, 2L)
  invisible()
}

