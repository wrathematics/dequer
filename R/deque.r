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
combine <- function(dl1, dl2)
{
  .Call("R_deque_combine", dl1, dl2)
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



#' @export
str.deque <- function(object)
{
  .Call("R_deque_str", object)
  invisible()
}



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

