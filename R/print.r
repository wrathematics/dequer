#' @useDynLib dequer R_deque_print
printer <- function(x, output="summary", printorder)
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
      printlevel <- PRINT_FEW
    else
      printlevel <- PRINT_ALL
    
    .Call(R_deque_print, x, printlevel, printorder)
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
#' A queue, stack, or deque.
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
print.deque <- function(x, ..., output="summary")
{
  printer(x=x, output=output, printorder=PRINTORDER_FORWARD)
}

#' @rdname printer
#' @export
print.stack <- function(x, ..., output="summary")
{
  printer(x=x, output=output, printorder=PRINTORDER_FORWARD)
}

#' @rdname printer
#' @export
print.queue <- function(x, ..., output="summary")
{
  printer(x=x, output=output, printorder=PRINTORDER_REVERSE)
}
