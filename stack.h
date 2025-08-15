#ifndef STACK_H
#define STACK_H

#include <stdio.h>
#include <string.h>

typedef enum { DOUBLE, CHAR, STRING } data_types;

#define DEFAULT_STACK_SIZE 4

typedef struct items {
    union data {
        double decimal;
        char* string;
        char character;
    } data;
    data_types type;
} items;

typedef struct stack {
    items *items;
    int top;
    unsigned int size;
    unsigned int capacity;
} stack;

stack* init_stack();
void push(stack *p, items* item);
items pop(stack *p);
void free_stack(stack *stack);

#endif