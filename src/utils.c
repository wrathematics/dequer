/*  Copyright (c) 2015, Schmidt
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

#define PRINT_FEW 1
#define PRINT_ALL 2

#define TRUNCLEN 5

SEXP R_deque_print(SEXP deque_ptr, SEXP printlevel)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  list_t *l = dl->start;
  
  int printlen, truncated;
  
  if (INTEGER(printlevel)[0] == PRINT_FEW)
  {
    if (dl->len < TRUNCLEN)
    {
      printlen = dl->len;
      truncated = 0;
    }
    else
    {
      printlen = TRUNCLEN;
      truncated = 1;
    }
  }
  else
  {
    printlen = dl->len;
    truncated = 0;
  }
  
  
  for (int i=0; i<printlen; i++)
  {
    Rprintf("[[%d]]\n", i+1);
    PrintValue(l->data);
    Rprintf("\n");
    l = l->next;
  }
  
  if (truncated)
    Rprintf("[------- Results truncated -------]\n\n");
  
  return R_NilValue;
}



SEXP R_deque_length(SEXP deque_ptr)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  
  SEXP len;
  PROTECT(len = allocVector(INTSXP, 1));
  
  INTEGER(len)[0] = (int) dl->len;
  
  UNPROTECT(1);
  return len;
}



SEXP R_deque_reverse(SEXP deque_ptr)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  
  deque_reverse(dl);
  
  return R_NilValue;
}

