/* Automatically generated. Do not edit by hand. */

#include <R.h>
#include <Rinternals.h>
#include <R_ext/Rdynload.h>
#include <stdlib.h>

extern SEXP R_deque_combine(SEXP deque_ptr1, SEXP deque_ptr2);
extern SEXP R_deque_create();
extern SEXP R_deque_headsortails(SEXP deque_ptr, SEXP n, SEXP headsortails);
extern SEXP R_deque_length(SEXP deque_ptr);
extern SEXP R_deque_pop(SEXP deque_ptr);
extern SEXP R_deque_popback(SEXP deque_ptr);
extern SEXP R_deque_print(SEXP deque_ptr, SEXP printlevel, SEXP printorder_);
extern SEXP R_deque_push(SEXP deque_ptr, SEXP data);
extern SEXP R_deque_pushback(SEXP deque_ptr, SEXP data);
extern SEXP R_deque_reverse(SEXP deque_ptr);
extern SEXP R_deque_split(SEXP deque_ptr, SEXP k);
extern SEXP R_deque_str(SEXP deque_ptr, SEXP obj_type, SEXP printorder_);
extern SEXP R_deque_to_Rlist(SEXP deque_ptr);

static const R_CallMethodDef CallEntries[] = {
  {"R_deque_combine", (DL_FUNC) &R_deque_combine, 2},
  {"R_deque_create", (DL_FUNC) &R_deque_create, 0},
  {"R_deque_headsortails", (DL_FUNC) &R_deque_headsortails, 3},
  {"R_deque_length", (DL_FUNC) &R_deque_length, 1},
  {"R_deque_pop", (DL_FUNC) &R_deque_pop, 1},
  {"R_deque_popback", (DL_FUNC) &R_deque_popback, 1},
  {"R_deque_print", (DL_FUNC) &R_deque_print, 3},
  {"R_deque_push", (DL_FUNC) &R_deque_push, 2},
  {"R_deque_pushback", (DL_FUNC) &R_deque_pushback, 2},
  {"R_deque_reverse", (DL_FUNC) &R_deque_reverse, 1},
  {"R_deque_split", (DL_FUNC) &R_deque_split, 2},
  {"R_deque_str", (DL_FUNC) &R_deque_str, 3},
  {"R_deque_to_Rlist", (DL_FUNC) &R_deque_to_Rlist, 1},
  {NULL, NULL, 0}
};
void R_init_dequer(DllInfo *dll)
{
  R_registerRoutines(dll, NULL, CallEntries, NULL, NULL);
  R_useDynamicSymbols(dll, FALSE);
}
