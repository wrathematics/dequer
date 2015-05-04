#' @export
as.list.deque <- function(deque)
{
  .Call("R_deque_to_Rlist", deque)
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


