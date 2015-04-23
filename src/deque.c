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

static void *vptr;


deque_t *deque_create()
{
  deque_t *dl;
  dl = malloc(sizeof(*dl));
  
  dl->start = NULL;
  dl->end = NULL;
  dl->len = 0;
  
  return dl;
}


void deque_push(deque_t *dl, SEXP data)
{
  list_t *l;
  l = malloc(sizeof(*l));
  
  l->prev = NULL;
  l->next = dl->start;
  l->data = data;
  
  if (dl->start) 
    dl->start->prev = l;
  else
    dl->start = l;
  
  if (!dl->end) dl->end = l;
  dl->start = l;
  dl->len++;
}



void deque_pushback(deque_t *dl, SEXP data)
{
  list_t *l;
  l = malloc(sizeof(*l));
  
  l->prev = dl->end;
  l->next = NULL;
  l->data = data;
  
  if (dl->end) 
    dl->end->next = l;
  else
    dl->end = l;
  
  if (!dl->start) dl->start = l;
  dl->end = l;
  dl->len++;
}



void deque_pop(deque_t *dl)
{
  if (dl->len == 0) return;
  
  list_t *l = dl->start;
  if (l->next) l->next->prev = NULL;
  
  dl->start = l->next;
  dl->len--;
  
  R_ReleaseObject(l->data);
  free(l);
}



void deque_popback(deque_t *dl)
{
  if (dl->len == 0) return;
  
  list_t *l = dl->end;
  
  if (l->prev) l->prev->next = NULL;
  dl->end = l->prev;
  dl->len--;
  
  R_ReleaseObject(l->data);
  free(l);
}



void deque_reverse(deque_t *dl)
{
  const uint32_t len = dl->len;
  list_t *l;
  
  l = dl->start;
  dl->start = dl->end;
  dl->end = l;
  
  for (int i=0; i<len; i++)
  {
    vptr = l->next;
    l->next = l->prev;
    l->prev = vptr;
    
    l = vptr;
  }
}



void deque_free(deque_t *dl)
{
  list_t *l = dl->start;
  
  while (l)
  {
    if (l->data != R_NilValue)
      R_ReleaseObject(l->data);
    
    vptr = l->next;
    free(l);
    l = vptr;
  }
  
  free(dl);
}

