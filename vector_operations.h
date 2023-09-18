#ifndef VECTOR_OPERATIONS_H_
#define VECTOR_OPERATIONS_H_

#define _USE_MATH_DEFINES
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <math.h>

typedef struct vector {
    int dim;
    float *components;
} vector;

vector default_vec();
vector newVec(int dimension, float *a);
vector vecAdd(int noVecs, ...);
vector vecSub(int noVecs, ...);
void printVec(vector a);
float degrees(float radians);
float radians(float degrees);
void freeVec(int noVecs, ...);

#endif