/*  Copyright (c) 2015-2016 Drew Schmidt
    All rights reserved.
    
    Redistribution and use in source and binary forms, with or without
    modification, are permitted provided that the following conditions are met:
    
    1. Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
    
    2. Redistributions in binary form must reproduce the above copyright
    notice, this list of conditions and the following disclaimer in the
    documentation and/or other materials provided with the distribution.
    
    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
    "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
    TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
    PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR
    CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
    EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
    PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
    PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
    LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
    NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/


#include "deque.h"

#define MIN(x,y) (x<y?x:y)

#define PRINT_TRUNCLEN 5
#define STR_TRUNCLEN   25



SEXP R_deque_print(SEXP deque_ptr, SEXP printlevel, SEXP printorder_)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  CHECKPTR(dl);
  list_t *l;
  const int printorder = INTEGER(printorder_)[0];
  
  int printlen, truncated;
  
  if (dl->len == 0)
  {
    Rprintf("deque()\n");
    return R_NilValue;
  }
  
  if (INTEGER(printlevel)[0] == PRINT_FEW)
  {
    printlen = MIN(dl->len,PRINT_TRUNCLEN);
    truncated = dl->len<PRINT_TRUNCLEN?0:1;
  }
  else
  {
    printlen = dl->len;
    truncated = 0;
  }
  
  
  if (printorder == PRINTORDER_FORWARD)
    l = dl->start;
  else
    l = dl->end;
  
  for (int i=0; i<printlen; i++)
  {
    Rprintf("[[%d]]\n", i+1);
    PrintValue(l->data);
    Rprintf("\n");
    l = (printorder == 1 ? l->next : l->prev);
  }
  
  if (truncated)
    Rprintf("[------- Results truncated -------]\n\n");
  
  return R_NilValue;
}



SEXP R_deque_length(SEXP deque_ptr)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  CHECKPTR(dl);
  
  SEXP len;
  PROTECT(len = allocVector(INTSXP, 1));
  
  INTEGER(len)[0] = (int) dl->len;
  
  UNPROTECT(1);
  return len;
}



SEXP R_deque_reverse(SEXP deque_ptr)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  CHECKPTR(dl);
  
  deque_reverse(dl);
  
  return R_NilValue;
}



static inline SEXP evalfun_stringarg(const char *const restrict fun, const char *const restrict arg)
{
  SEXP ret, expr, fun_install, arg_str;
  PROTECT(fun_install = install(fun));
  PROTECT(arg_str = ScalarString(mkChar(arg)));
  PROTECT(expr = lang2(fun_install, arg_str));
  PROTECT(ret = eval(expr, R_GlobalEnv));
  
  UNPROTECT(4);
  return ret;
}

SEXP R_deque_str(SEXP deque_ptr, SEXP obj_type, SEXP printorder_)
{
  SEXP basePackage;
  SEXP strfun;
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  CHECKPTR(dl);
  list_t *l;
  const int len = dl->len;
  const int printlen = MIN(len, STR_TRUNCLEN);
  const int printorder = INTEGER(printorder_)[0];
  
  if (len == 0)
  {
    Rprintf(" %s()\n", CHARPT(obj_type, 0));
    return R_NilValue;
  }
  
  PROTECT(basePackage = evalfun_stringarg("getNamespace", "utils"));
  PROTECT(strfun = install("str"));
  
  Rprintf("%s of %d\n", CHARPT(obj_type, 0), len);
  
  if (printorder == PRINTORDER_FORWARD)
    l = dl->start;
  else
    l = dl->end;
  
  for (int i=0; i<printlen; i++)
  {
    Rprintf(" $ :");
    
    SEXP expr;
    PROTECT(expr = lang2(strfun, l->data));
    eval(expr, basePackage);
    UNPROTECT(1);
    
    l = (printorder == PRINTORDER_FORWARD ? l->next : l->prev);
  }
  
  if (len > printlen)
    Rprintf("  [output truncated to %d of %d elements]\n", printlen, len);
  
  UNPROTECT(2);
  return R_NilValue;
}



SEXP R_deque_headsortails(SEXP deque_ptr, SEXP n, SEXP headsortails)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  CHECKPTR(dl);
  list_t *l;
  
  const int len = dl->len;
  const int printlen = MIN(len, INTEGER(n)[0]);
  const int hot = INTEGER(headsortails)[0];
  
  if (len == 0)
  {
    Rprintf("deque()\n");
    return R_NilValue;
  }
  
  
  if (hot == PEEKER_HEAD)
    l = dl->start;
  else// if (hot == PEEKER_TAIL)
  {
    l = dl->end;
    
    for (int i=1; i<printlen; i++)
      l = l->prev;
  }
  
  for (int i=0; i<printlen; i++)
  {
    Rprintf("[[%d]]\n", i+1);
    PrintValue(l->data);
    Rprintf("\n");
    
    l = l->next;
  }
  
  return R_NilValue;
}
