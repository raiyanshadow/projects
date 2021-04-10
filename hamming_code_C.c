// this program only accepts array with n^2 elements 
// i.e. array[4], [16], [32], [128]...


#include <stdio.h>
#include <math.h>
#define MAXLEN 4                // you change this depending on the largest digit of the corresponding binary number, in this example 1110 is the biggest binary digit, hence MAXLEN is 4

long int binConvert(long int a);
int *binBag(long int a);
int numLen(long int a);
int revBinConvert(int *a);
int binArrayNumLen(int *a);

int main()
{
    int code[16] = {0, 1, 1, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 1, 1, 0};           // change this to your liking, or make it dynamic :)
    int count = 0;
    
    for (int i = 0; i < 16; i++)
    {
        count += (code[i] == 1 ? 1 : 0);
    }
    
    long int preBin[count];
    long int postBin[count];
    int finBin[count][MAXLEN];
    
    for (int i = 0, j = 0; i < 16; i++)
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
    
    for (int i = 0; i < count; i++)
    {
        for (int j = 0; j < MAXLEN; j++)
        {
            finBin[i][j] = binBag(postBin[i])[j];
            printf("%i, ", binBag(postBin[i])[j]);
        }
        printf("\n");
    }
    
    long int temp = 0;
    long int actemp = 0;
    int mode = 0;
    int finum[MAXLEN];
    int finfinum = 0;
    
    for (int i = 0; i <= MAXLEN; i++, mode++)
    {
        for (int j = 0; j < count; j++)
        {
            finum[i] += finBin[j][i];
        }
        finum[i] %= 2;
    }
    
    for (int i = MAXLEN - binArrayNumLen(finum) - 1, k = MAXLEN-1; i < MAXLEN; i++, k--)
    {
        finfinum += finum[i] * pow(10, k);
    }
    
    for (int i = 0; i < MAXLEN; i++)
    {
        printf("= %i\n", finum[i]);
    }
    
    printf("Error found at 0x%i (Position %i)", binConvert(revBinConvert(finum)), revBinConvert(finum));    // lol, i dont know why the error address is always 0x100 if i just use finum, oh well
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

int *binBag(long int a)
{
    int len = numLen(a) - 1;
    int offset = MAXLEN - numLen(a);
    long int s1 = a;
    int s2 = 0;
    static int num[MAXLEN];
    for (int i = len; i >= 0; i--, s2++)
    {
        if (a < pow(10, i))
        {
            num[s2] = 0;
        }
        else if (s1 < pow(10, MAXLEN-1))
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
    return num;
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

int revBinConvert(int *a)
{
    int actual = 0;
    
    for (int i = 0, j = MAXLEN-1; i < MAXLEN; i++, j--)
    {
        actual += (a[i] == 1 ? pow(2, j) : 0);
    }
    
    return actual;
}

int binArrayNumLen(int *a)
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
