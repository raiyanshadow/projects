#include "vector_operations.h"

vector default_vec()
{
    float *a = {0};
    vector ret = newVec(1, a);
    return ret;
}

vector newVec(int dimension, float *a)
{
    vector ret;
    ret.dim = dimension;
    if (dimension < 1)
    {
        printf("Invalid vector dimension\n");
        return default_vec();
    }

    ret.components = malloc(dimension*sizeof(float));
    for (int i = 0; i < dimension; i++)
    {
        ret.components[i] = a[i];
    }
    return ret;
}

vector vecAdd(int noVecs, ...)
{
    va_list vecs;

    va_start(vecs, noVecs);
    vector start = va_arg(vecs, vector);
    float *a = malloc(start.dim*sizeof(float));
    for (int i = 0; i < start.dim; i++)
    {
        a[i] = start.components[i];
    }
    vector ret = newVec(start.dim, a);
    free(a);
    for (int i = 0; i < noVecs-1; i++)
    {
        vector next = va_arg(vecs, vector);
        if (next.dim != start.dim)
        {
            printf("Error: cannot add vectors of differing dimensions\n");
            return default_vec();
        }
        for (int j = 0; j < start.dim; j++)
        {
            ret.components[j] += next.components[j];
        }
    }
    va_end(vecs);

    return ret;
}

vector vecSub(int noVecs, ...)
{
    va_list vecs;

    va_start(vecs, noVecs);
    vector start = va_arg(vecs, vector);
    float *a = malloc(start.dim*sizeof(float));
    for (int i = 0; i < start.dim; i++)
    {
        a[i] = start.components[i];
    }
    vector ret = newVec(start.dim, a);
    free(a);
    for (int i = 0; i < noVecs-1; i++)
    {
        vector next = va_arg(vecs, vector);
        if (next.dim != start.dim)
        {
            printf("Error: cannot add vectors of differing dimensions\n");
            return default_vec();
        }
        for (int j = 0; j < start.dim; j++)
        {
            ret.components[j] -= next.components[j];
        }
    }
    va_end(vecs);
}

void printVec(vector a)
{
    printf("< ");
    for (int i = 0; i < a.dim; i++)
    {
        printf("%f, ", a.components[i]);
    }
    printf(">\n");
}

float degrees(float radians)
{
    return 180 * radians / M_PI;
}

float radians(float degrees)
{
    return degrees * M_PI / 180;
}

void freeVec(int noVecs, ...)
{
    va_list args;
    vector vp;
    va_start(args, noVecs);
    for (int i = 0; i < noVecs; i++)
    {
        vp = va_arg(args, vector);
        free(vp.components);
    }
    va_end(args);
}