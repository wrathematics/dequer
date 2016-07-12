#' @export
str.deque <- function(object, ...)
{
  .Call(R_deque_str, object, "Deque", PRINTORDER_FORWARD)
  invisible()
}

#' @export
str.stack <- function(object, ...)
{
  .Call(R_deque_str, object, "Stack", PRINTORDER_FORWARD)
  invisible()
}

#' @export
str.queue <- function(object, ...)
{
  .Call(R_deque_str, object, "Queue", PRINTORDER_REVERSE)
  invisible()
}
