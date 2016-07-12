#' @export
length.deque <- function(x)
{
  .Call(R_deque_length, x)
}



#' @export
length.queue <- function(x)
{
  .Call(R_deque_length, x)
}



#' @export
length.stack <- function(x)
{
  .Call(R_deque_length, x)
}
