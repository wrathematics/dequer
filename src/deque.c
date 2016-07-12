/*  Copyright (c) 2015-2016, Schmidt
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
  list_t *tmp;
  
  if (dl->len == 0) return;
  
  list_t *l = dl->start;
  if (l->next)
  {
    tmp = l;
    l = l->next;
    l->prev = NULL;
    
    l = tmp;
  }
  
  dl->start = l->next;
  if (dl->len == 1) dl->end = NULL;
  dl->len--;
  
  R_ReleaseObject(l->data);
  free(l);
}



void deque_popback(deque_t *dl)
{
  list_t *tmp;
  
  if (dl->len == 0) return;
  
  list_t *l = dl->end;
  
  if (l->prev)
  {
    tmp = l;
    l = l->prev;
    l->next = NULL;
    
    l = tmp;
  }
  
  dl->end = l->prev;
  if (dl->len == 1) dl->start = NULL;
  dl->len--;
  
  R_ReleaseObject(l->data);
  free(l);
}



void deque_reverse(deque_t *dl)
{
  list_t *tmp;
  const uint32_t len = dl->len;
  list_t *l;
  
  l = dl->start;
  dl->start = dl->end;
  dl->end = l;
  
  for (int i=0; i<len; i++)
  {
    tmp = l->next;
    l->next = l->prev;
    l->prev = tmp;
    
    l = tmp;
  }
}



// split dl after k
int deque_split(const uint32_t k, deque_t *dl, deque_t **dl2)
{
  if (dl->len < k) return -1;
  int i;
  *dl2 = deque_create();
  list_t *l;
  
  if (k <= dl->len/2)
  {
    l = dl->start;
    for (i=0; i<k; i++)
      l = l->next;
  }
  else
  {
    l = dl->end;
    for (i=dl->len; i>k+1; i--)
      l = l->prev;
  }
  
  (*dl2)->len = dl->len - k;
  
  dl->end = l->prev;
  dl->len = k;
  
  l->prev = NULL;
  (*dl2)->start = l;
  (*dl2)->end = dl->end;
  
  
  l = dl->end;
  l->next = NULL;
  
  return 0;
}



// this is very unsafe if you do dumb shit
int deque_combine(deque_t *dl, deque_t *dl2)
{
  list_t *l;
  l = dl->end;
  
  l->next = dl2->start;
  dl2->start->prev = l;
  
  dl->end = dl2->end;
  
  dl->len += dl2->len;
  
  dl2->start = NULL;
  dl2->end = NULL;
  dl2->len = 0;
  
  return 0;
}



void deque_free(deque_t *dl)
{
  list_t *tmp;
  list_t *l = dl->start;
  
  while (l)
  {
    if (l->data != R_NilValue)
      R_ReleaseObject(l->data);
    
    tmp = l->next;
    free(l);
    l = tmp;
  }
  
  free(dl);
}
