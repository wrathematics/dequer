#' @export
str.deque <- function(object, ...)
{
  .Call("R_deque_str", object)
  invisible()
}

