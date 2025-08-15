#include "stack.h"

stack* init_stack(void)
{
    stack* p = malloc(sizeof(stack));
    if (!p) { 
        return NULL; 
    }
    p->items = malloc(sizeof(items)*DEFAULT_STACK_SIZE);
    if (!p->items) {
        free(p);
        return NULL;
    }

    p->top = -1; // stack is empty
    p->size = 0;
    p->capacity = DEFAULT_STACK_SIZE;

    return p; 
}

void free_stack(stack* p)
{
    free(p->items);
    free(p);
}

void push(stack* p, items* item)
{
    // 100% of stack size reached, then double
    if (p->size == p->capacity)
    {
        unsigned int new_size = p->size*2;
        items *new_items = realloc(p->items, sizeof(items) * new_size);
        if (!new_items) {
            return;
        }
        p->items = new_items;
        p->size = new_size;
    }
    int idx = ++p->top;
    p->items[idx].type = item->type;

    switch (item->type)
    {
        case DOUBLE:
            p->items[idx].data.decimal = item->data.decimal;
            break;
        case CHAR:
            p->items[idx].data.character = item->data.character;
            break;
        case STRING:
            p->items[idx].data.string = strdup(item->data.string);
            break;
    }

    p->size++;
}

items pop(stack* p)
{
    if (p->top == -1)
    {
        printf("Stack is empty\n");
        return (items){0};
    }
    
    items to_pop = p->items[p->top--];
    p->size--;

    if (to_pop.type == STRING)
    {
        char *tmp = to_pop.data.string;
        to_pop.data.string = strdup(tmp);
        free(tmp);
    }

    // 50% of stack size reached, then shrink
    if (p->size < p->capacity / 4 && p->capacity > DEFAULT_STACK_SIZE)
    {
        unsigned int new_size = p->size / 2;
        items *new_items = realloc(p->items, sizeof(items) * new_size);
        if (!new_items) {
            return (items){0};
        }
        p->items = new_items;
        p->size = new_size;
    }
    
    return to_pop;
}

void print_stack(stack* p)
{
    printf("{");
    char* extra_space = ", ";
    for (int i = p->top; i >= 0; i--) {
        if (i == 0)
        {
            extra_space = "}\n";
        }
        switch (p->items[i].type) {
            case DOUBLE:
                printf("%.2f%s", p->items[i].data.decimal, extra_space);
                break;
            case CHAR:
                printf("%c%s", p->items[i].data.character, extra_space);
                break;
            case STRING:
                printf("%s%s", p->items[i].data.string, extra_space);
                break;
        }
    }
}
