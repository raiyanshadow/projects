#ifndef EXPRESSION_H
#define EXPRESSION_H

#include <stdio.h>
#include "stack.h"

typedef enum { VARIABLE, CONSTANT, NUMBER, FUNCT, OP, CLOSURE } node_types;

typedef struct node {
    struct node *left, *right, *next, *prev, *parent;
    union { 
        double value; 
        char* name; 
        char op; } 
    data;
    node_types type;
} node;

typedef struct expr_tree {
    node *root;
    int height;
} expr_tree;

void free_expr_tree(expr_tree *tree);
void free_node(node *node);
void print_expr_tree(expr_tree *tree);
double eval_expr_tree(expr_tree *tree);
expr_tree *make_expr_tree(char *expression);
node *make_node(char read);

#endif
