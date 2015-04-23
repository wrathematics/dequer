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
rev.deque <- function(x)
{
  .Call("R_deque_reverse", x)
  invisible()
}



#' @export
print.deque <- function(x, ..., output="summary")
{
  output <- match.arg(tolower(output), c("summary", "truncated", "full"))
  
  if (output == "summary")
    print(paste("A deque object with", length(x), "elements."))
  else
  {
    if (output == "truncated")
      printlevel <- 1L
    else
      printlevel <- 2L
    
    .Call("R_deque_print", x, printlevel)
  }
  invisible()
}



#' @export
length.deque <- function(x)
{
  .Call("R_deque_length", x)
}



#' @export
as.list.deque <- function(deque)
{
  .Call("R_deque_to_Rlist", deque)
}



#' @export
str.deque <- function(object)
{
  .Call("R_deque_str", object)
}

