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
rev.deque <- function(x)
{
  .Call("R_deque_reverse", x)
  invisible()
}



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

