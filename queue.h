#ifndef QUEUE_H
#define QUEUE_H

#include <stdio.h>
#include <string.h>

typedef enum { DOUBLE, CHAR, STRING } data_types;

#define DEFAULT_QUEUE_SIZE 4

typedef struct items {
    union {
        double decimal;
        char character;
        char* string;
    } data;
    data_types type;
} items;

typedef struct queue {
    items *items;
    int front;
    unsigned int size;
    unsigned int capacity;
} queue;

queue* init_queue();
void resize_queue(queue *q, unsigned int new_capacity);
void enqueue(queue* q, items* item);
items dequeue(queue* q);
void free_queue(queue *q);
void print_queue(queue *q);

#endif