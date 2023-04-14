#define _USE_MATH_DEFINES
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <math.h>

typedef struct vector {
    float magnitude;
    float direction;
    char* unit;
} vector;

vector default_vec();
vector newVec(float magnitude, float direction, char *unit);
void vecAdd(vector a, vector b, vector *ret);
void vecSub(vector a, vector b, vector *ret);
void printVec(vector a);
float degrees(float radians);
float radians(float degrees);

int main()
{
    vector a = newVec(4.3, 50, "N");
    vector b = newVec(42.2, 45, "N");
    vector c = default_vec();
    vecAdd(a, b, &c);
    printf("Vector A: ");
    printVec(a);
    printf("Vector B: ");
    printVec(b);
    printf("Vector A - Vector B = ");
    printVec(c);
    return 0;
}

vector default_vec()
{
    vector ret = newVec(0, 0, "NULL");
    return ret;
}

vector newVec(float magnitude, float direction, char *unit)
{
    vector ret;
    ret.magnitude = magnitude;
    ret.direction = direction;
    ret.unit = unit;
    return ret;
}

void vecAdd(vector a, vector b, vector *ret)
{
    if (a.unit != b.unit)
    {
        printf("Cannot add vectors of differing units\n");
        return;
    }
    float adir = radians(a.direction);
    float bdir = radians(b.direction);
    float x = (a.magnitude * cos(adir)) + (b.magnitude * cos(bdir));
    float y = (a.magnitude * sin(adir)) + (b.magnitude * sin(bdir));
    ret->magnitude = (float)sqrt(pow(x, 2) + pow(y, 2));
    ret->direction = degrees(atan(y / x));
    ret->unit = a.unit;
}

void vecSub(vector a, vector b, vector *ret)
{
    if (a.unit != b.unit)
    {
        printf("Cannot subtract vectors of differing units\n");
        return;
    }
    b.direction = 180 - b.direction;
    vecAdd(a, b, ret);
    b.direction += 180;
}

void printVec(vector a)
{
    printf("%f %s [%.2f]\n", a.magnitude, a.unit, a.direction);
}

float degrees(float radians)
{
    return 180 * radians / M_PI;
}

float radians(float degrees)
{
    return degrees * M_PI / 180;
}