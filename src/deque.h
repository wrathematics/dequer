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


#ifndef _DEQUE_H_
#define _DEQUE_H_


#include <R.h>
#include <Rinternals.h>
#include <Rdefines.h>

#include <stdlib.h>
#include <stdint.h>

typedef struct deque_t{
  struct list_t *start;
  struct list_t *end;
  uint32_t len;
} deque_t;

typedef struct list_t{
  struct list_t *next;
  struct list_t *prev;
  SEXP data;
} list_t;



// External pointer shorthand
#define newRptr(ptr,Rptr,fin) PROTECT(Rptr = R_MakeExternalPtr(ptr, R_NilValue, R_NilValue));R_RegisterCFinalizerEx(Rptr, fin, TRUE)
#define getRptr(ptr) R_ExternalPtrAddr(ptr);

// Misc R shorthand
#define CHARPT(x,i)	((char*)CHAR(STRING_ELT(x,i)))
#define INT(x) INTEGER(x)[0]


deque_t *deque_create();
void deque_push(deque_t *dl, SEXP data);
void deque_pushback(deque_t *dl, SEXP data);
void deque_pop(deque_t *dl);
void deque_popback(deque_t *dl);
void deque_reverse(deque_t *dl);
void deque_free(deque_t *dl);
void deque_print(deque_t *dl);


#endif

