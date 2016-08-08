#' @export
as.list.deque <- function(x, ...)
{
  .Call(R_deque_to_Rlist, x)
}



#' @export
as.list.queue <- function(x, ...)
{
  rev(x)
  ret <- .Call(R_deque_to_Rlist, x)
  rev(x)
  
  ret
}



#' @export
as.list.stack <- function(x, ...)
{
  ret <- .Call(R_deque_to_Rlist, x)
  
  ret
}
