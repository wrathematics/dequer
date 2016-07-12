#' @export
as.list.deque <- function(x, ...)
{
  .Call(R_deque_to_Rlist, x)
}



#' @export
as.list.queue <- function(x, ...)
{
  rev(x)
  .Call(R_deque_to_Rlist, x)
}



#' @export
as.list.stack <- function(x, ...)
{
  .Call(R_deque_to_Rlist, x)
}
