#' dequer
#' 
#' Queues, stacks, and 'deques' are list-like, abstract data types. 
#' These are meant to be very cheap to "grow", or insert new objects into.
#' A typical use case involves storing data in a list in a streaming fashion,
#' when you do not necessarily know how may elements need to be stored.
#' Unlike R's lists, the new data structures provided here are not
#' necessarily stored contiguously, making insertions and deletions at the
#' front/end of the structure much faster.  The underlying implementation
#' is new and uses a head/tail doubly linked list; thus, we do not rely on R's
#' environments or hashing.  To avoid unnecessary data copying, most operations
#' on these data structures are performed via side-effects.
#' 
#' @name dequer-package
#' @docType package
#' @keywords Package
NULL
