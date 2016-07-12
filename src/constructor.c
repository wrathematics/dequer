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


static void deque_finalize(SEXP ptr)
{
  if (NULL == R_ExternalPtrAddr(ptr))
    return;
  
  deque_t *dl = (deque_t *) R_ExternalPtrAddr(ptr);
  deque_free(dl);
  R_ClearExternalPtr(ptr);
}



SEXP R_deque_create()
{
  SEXP dl_ptr;
  deque_t *dl = deque_create();
  
  newRptr(dl, dl_ptr, deque_finalize);
  
  UNPROTECT(1);
  return dl_ptr;
}



SEXP R_deque_push(SEXP deque_ptr, SEXP data)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  
  SEXP cpdata = duplicate(data);
  R_PreserveObject(cpdata);
  deque_push(dl, cpdata);
  
  return R_NilValue;
}



SEXP R_deque_pushback(SEXP deque_ptr, SEXP data)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  
  SEXP cpdata = duplicate(data);
  R_PreserveObject(cpdata);
  deque_pushback(dl, cpdata);
  
  return R_NilValue;
}



SEXP R_deque_pop(SEXP deque_ptr)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  
  deque_pop(dl);
  
  return R_NilValue;
}



SEXP R_deque_popback(SEXP deque_ptr)
{
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  
  deque_popback(dl);
  
  return R_NilValue;
}



SEXP R_deque_split(SEXP deque_ptr, SEXP k)
{
  SEXP ret;
  deque_t *dl = (deque_t *) getRptr(deque_ptr);
  deque_t *dl2;
  
  int check = deque_split(INTEGER(k)[0], dl, &dl2);
  if (check)
    error("something went wrong!");
  
  newRptr(dl2, ret, deque_finalize);
  
  UNPROTECT(1);
  return ret;
}



SEXP R_deque_combine(SEXP deque_ptr1, SEXP deque_ptr2)
{
  deque_t *dl1 = (deque_t *) getRptr(deque_ptr1);
  deque_t *dl2 = (deque_t *) getRptr(deque_ptr2);
  
  deque_combine(dl1, dl2);
  
  return R_NilValue;
}
