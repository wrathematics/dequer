#' Printing Deques
#' 
#' @details
#' If \code{output=="summary"}, then just a simple representation of the n-gram
#' object will be printed.
#' 
#' If \code{output=="truncated"}, then the first 5 items will be
#' printed.
#' 
#' If \code{output=="full"} then the full list will be printed.
#' 
#' @param x
#' A deque.
#' @param output
#' A character string; determines what exactly is printed.
#' Options are "summary", "truncated", and "full".
#' @param ...
#' Unused.
#' 
#' @name print-deque
#' @rdname print-deque
#' @method print deque
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
    
    .Call(R_deque_print, x, printlevel)
  }
  invisible()
}
