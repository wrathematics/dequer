#' @export
str.deque <- function(object, ...)
{
  .Call("R_deque_str", object, "Deque")
  invisible()
}



#' @export
str.queue <- function(object, ...)
{
  .Call("R_deque_str", object, "Queue")
  invisible()
}



#' @export
str.stack <- function(object, ...)
{
  .Call("R_deque_str", object, "Stack")
  invisible()
}

