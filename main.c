#include "vector_operations.h"

int main()
{
    vector a = newVec(2, (float[2]){2, 4});
    vector b = newVec(2, (float[2]){-5, 3});
    vector d = newVec(2, (float[2]){6, -3});
    vector c = vecAdd(3, a, b, d);
    printVec(c);
    freeVec(4, a, b, c, d);
}