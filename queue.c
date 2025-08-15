#include "queue.h"

queue* init_queue()
{
    queue* q = malloc(sizeof(queue));
    if (!q)
    {
        return NULL;
    }
    q->items = malloc(sizeof(items) * DEFAULT_QUEUE_SIZE);
    if (!q->items)
    {
        free(q);
        return NULL;
    }
    q->front = 0; // queue is empty
    q->size = 0;
    q->capacity = DEFAULT_QUEUE_SIZE;

    return q;
}

void resize_queue(queue *q, unsigned int new_capacity)
{
    items* new_items = malloc(sizeof(items)*new_capacity);
    if (!new_items)
    {
        return;
    }

    for (unsigned int i = 0; i < q->size; i++)
    {
        items *src = &q->items[(q->front + i) % q->capacity];
        new_items[i].type = src->type;

        switch (src->type) {
            case DOUBLE:
                new_items[i].data.decimal = src->data.decimal;
                break;
            case CHAR:
                new_items[i].data.character = src->data.character;
                break;
            case STRING:
                new_items[i].data.string = strdup(src->data.string);
                break;
        }
    }
    free(q->items);
    q->items = new_items;
    q->front = 0;
    q->capacity = new_capacity;
}

void enqueue(queue* q, items* item)
{
    if (q->size == q->capacity)
    {
        resize_queue(q, q->capacity * 2);
    }

    unsigned int idx = (q->front + q->size) % q->capacity;
    q->items[idx].type = item->type;

    switch (item->type)
    {
        case DOUBLE:
            q->items[idx].data.decimal = item->data.decimal;
            break;
        case CHAR:
            q->items[idx].data.character = item->data.character;
            break;
        case STRING:
            q->items[idx].data.string = strdup(item->data.string);
            break;
    }

    q->size++;
}

items dequeue(queue* q)
{
    if (q->size == 0)
    {
        printf("Queue is empty\n");
        return (items){0};
    }
    items val = q->items[q->front];

    if (val.type == STRING)
    {
        char *tmp = val.data.string;
        val.data.string = strdup(tmp);
        free(tmp);
    }

    q->front = (q->front+1) % q->capacity;
    q->size--;

    if (q->capacity > DEFAULT_QUEUE_SIZE && q->size <= q->capacity / 4) {
        resize_queue(q, q->capacity / 2);
    }

    return val;
}

void free_item(items *it) {
    if (it->type == STRING && it->data.string != NULL) {
        free(it->data.string);
        it->data.string = NULL;
    }
}

void free_queue(queue *q)
{
    for (int i = 0; i < q->size; i++) {
        unsigned int idx = (q->front + i) % q->capacity;
        free_item(&q->items[idx]);
    }
    free(q->items);
    free(q);
}

void print_queue(queue* q)
{
    printf("{");
    char* extra_space = ", ";
    for (unsigned int i = 0; i < q->size; i++) {
        unsigned int index = (q->front + i) % q->capacity;
        if (i == q->size - 1)
        {
            extra_space = "}\n";
        }
        switch (q->items[index].type) {
            case DOUBLE:
                printf("%.2f%s", q->items[index].data.decimal, extra_space);
                break;
            case CHAR:
                printf("%c%s", q->items[index].data.character, extra_space);
                break;
            case STRING:
                printf("%s%s", q->items[index].data.string, extra_space);
                break;
        }
    }
}