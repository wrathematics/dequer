#' @export
length.deque <- function(x)
{
  .Call("R_deque_length", x)
}
