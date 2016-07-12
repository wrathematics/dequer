printer <- function(x, ..., output="summary")
{
  output <- match.arg(tolower(output), c("summary", "truncated", "full"))
  
  if (output == "summary")
  {
    len <- length(x)
    word <- ifelse(len != 1, "elements", "element")
    cat(paste("A", class(x), "with", len, word), "\n")
  }
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



#' Printing Deques, Stacks, and Queues
#' 
#' @details
#' If \code{output=="summary"}, then just a simple representation is printed.
#' 
#' If \code{output=="truncated"}, then the first 5 items will be
#' printed.
#' 
#' If \code{output=="full"} then the full data structure will be printed.
#' 
#' @param x
#' A deque.
#' @param output
#' A character string; determines what exactly is printed.
#' Options are "summary", "truncated", and "full".
#' @param ...
#' Unused.
#' 
#' @name printer
#' @rdname printer
#' @method print deque
#' @method print stack
#' @method print queue
NULL

#' @rdname printer
#' @export
print.deque <- printer

#' @rdname printer
#' @export
print.stack <- printer

#' @rdname printer
#' @export
print.queue <- printer
