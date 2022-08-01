// this program only accepts array with n^2 elements 
// i.e. array[4], [16], [32], [128]...


#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#define TYPE 32

int MAXLEN = log10(TYPE) / log10(2);

long int binConvert(long int a);
int binBag(long int a, int index);
int numLen(long int a);
int revBinConvert(int* a);
int binArrayNumLen(int* a);

int main()
{
    int code[TYPE] = { 1, 0, 1, 1, 1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0 }; // change this to your liking, or make it dynamic :)
    int count = 0;

    for (int i = 0; i < TYPE; i++)
    {
        count += (code[i] == 1 ? 1 : 0);
    }

    if (count % 2 == 0)
    {
        printf("No errors\n");
        return -1;
    }
    else
    {
        
    }

    long int *preBin = malloc(count * sizeof(long int));
    long int *postBin = malloc(count * sizeof(long int));
    int** finbin = malloc(count * sizeof(int*));
    for (int i = 0; i < count; i++)
    {
        finbin[i] = malloc(MAXLEN * sizeof(int));
    }

    for (int i = 0, j = 0; i < TYPE; i++)
    {
        if (code[i] == 1)
        {
            preBin[j] = i;
            j++;
        }
    }

    for (int i = 0; i < count; i++)
    {
        postBin[i] = binConvert(preBin[i]);
        printf("%li\n", postBin[i]);
    }
    printf("\n");

    int boolean = 0;
    int initialize = 0;

    for (int i = 0; i < count; i++)
    {
        for (int j = 0; j < MAXLEN; j++)
        {  
            finbin[i][j] = binBag(postBin[i], j);
            printf("%i, ", finbin[i][j]);
        }
        printf("\n");
    }

    int *finum = malloc(MAXLEN * sizeof(int));
    int finfinum = 0;

    for (int i = 0; i < MAXLEN; i++)
    {
        for (int j = 0; j < count; j++)
        {
            finum[i] += finbin[j][i];
        }
        finum[i] %= 2;
    }

    for (int i = MAXLEN - binArrayNumLen(finum), k = MAXLEN - 1; i < MAXLEN; i++, k--)
    {
        finfinum += finum[i] * pow(10, k);
    }

    for (int i = 0; i < MAXLEN; i++)
    {
        printf("= %i\n", finum[i]);
    }

    printf("Error found at 0x%li (Position %i)", finfinum, revBinConvert(finum));
    free(finum);
    free(finbin);
    free(postBin);
    free(preBin);
    return 0;
}

long int binConvert(long int a)
{
    double roughBinLen = log(a) / log(2);
    int binLen = floor(roughBinLen);
    long int bin = (a % 2 == 1 ? 1 : 0);
    a = floor(a / 2);

    for (int i = 1; i <= binLen; i++, a = floor(a / 2))
    {
        bin += (a % 2 == 1 ? pow(10, i) : 0);
    }
    return bin;
}

int binBag(long int a, int index)
{
    int offset = MAXLEN - numLen(a);
    long int s1 = a;
    int s2 = 0;
    int* num = malloc(MAXLEN * sizeof(int));
 
    for (int i = MAXLEN - 1; i >= 0; i--, s2++)
    {
        if (a < pow(10, i))
        {
            num[s2] = 0;
        }
        else if (s1 < pow(10, MAXLEN - 1))
        {
            num[i + offset] = a % 10;
            a /= 10;
        }
        else
        {
            num[i] = a % 10;
            a /= 10;
        }
    }
    int finalNum = num[index];
    free(num);
    return finalNum;
}

int numLen(long int a)
{
    int c = 0;
    for (int i = 0; a > 0; c++)
    {
        a /= 10;
    }
    if (a = 0)
    {
        c = 1;
    }
    return c;
}

int revBinConvert(int* a)
{
    int actual = 0;

    for (int i = 0, j = MAXLEN - 1; i < MAXLEN; i++, j--)
    {
        actual += (a[i] == 1 ? pow(2, j) : 0);
    }

    return actual;
}

int binArrayNumLen(int* a)
{
    int pos = 0;
    int haveseen = 0;
    int i = 0;
    int c = 0;
    while (haveseen == 0)
    {
        if (a[i] == 1)
        {
            pos = i;
            haveseen = 1;
        }
        else
        {
            i++;
        }
    }

    return MAXLEN - pos;
}
