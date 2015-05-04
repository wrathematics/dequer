#' @export
deque <- function()
{
  ret <- .Call("R_deque_create")
  class(ret) <- "deque"
  
  ret
}



#' Add to front
#' 
#' @export
push <- function(deque, data)
{
  .Call("R_deque_push", deque, data)
  invisible()
}



#' Add to back
#' 
#' @export
pushback <- function(deque, data)
{
  .Call("R_deque_pushback", deque, data)
  invisible()
}



#' Remove from front.
#' 
#' @export
pop <- function(deque)
{
  .Call("R_deque_pop", deque)
  invisible()
}



#' Remove from back
#' 
#' @export
popback <- function(deque)
{
  .Call("R_deque_popback", deque)
  invisible()
}



#' @export
sep <- function(dl, k)
{
  k <- as.integer(k)
  
  if (k > length(dl))
    stop("")
  if (k < 0)
    stop("")
  
  ret <- .Call("R_deque_split", dl, k)
  class(ret) <- "deque"
  
  ret
}



#' @export
combine <- function(dl1, dl2)
{
  .Call("R_deque_combine", dl1, dl2)
  invisible()
}

