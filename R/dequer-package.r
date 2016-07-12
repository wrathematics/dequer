#' dequer
#' 
#' A deque (pronounced like "deck") is a "double ended queue".  This
#' behaves somewhat like a list in R; but unlike an R list (which is
#' a contiguous array of pointers), the memory of a deque isn't
#' necessarily contiguous.
#' 
#' @useDynLib dequer R_deque_create R_deque_combine R_deque_headsortails 
#' R_deque_length R_deque_pop R_deque_popback R_deque_print R_deque_push
#' R_deque_pushback R_deque_reverse R_deque_split R_deque_str R_deque_to_Rlist 
#' 
#' @name dequer-package
#' @docType package
#' @author Drew Schmidt \email{wrathematics AT gmail.com}
#' @keywords Package
NULL
