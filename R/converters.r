#' @export
as.list.deque <- function(x, ...)
{
  .Call("R_deque_to_Rlist", x)
}



### TODO return list with head/tail, add inspectonly argument
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



#' @export
#"[[".deque <- function(deque, index)
#{
#  index <- unique(sort(index))
#  if (length(index) < length(deque))
#    warning("")
#  else if (length(index) > length(deque))
#    stop("too many indices")
#  
#  .Call("R_deque_to_Rlist", deque)
#}


