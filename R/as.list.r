#' @export
as.list.deque <- function(x, ...)
{
  .Call("R_deque_to_Rlist", x)
}

