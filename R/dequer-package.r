#' dequer
#' 
#' Queues, stacks, and 'deques' are list-like, abstract data types. 
#' These are meant to be very cheap to "grow", or insert new objects into.
#' A typical use case involves storing data in a list in a streaming fashion,
#' when you do not necessarily know how may elements need to be stored.
#' Unlike R's lists, data the new data structures provided here is not
#' necessarily stored contiguously, making insertions and deletions at the
#' front/end of the structure much faster.  The underlying implementation here
#' is new and uses a head/tail doubly linked list; thus, we do not rely on R's
#' environments or hashing.  To avoid unnecessary data copying, most operations
#' on these data structures are performed via side-effects.
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
