#' @export
str.deque <- function(object, ...)
{
  .Call(R_deque_str, object, "deque", PRINTORDER_FORWARD)
  invisible()
}

#' @export
str.stack <- function(object, ...)
{
  .Call(R_deque_str, object, "stack", PRINTORDER_FORWARD)
  invisible()
}

#' @export
str.queue <- function(object, ...)
{
  .Call(R_deque_str, object, "queue", PRINTORDER_REVERSE)
  invisible()
}
