/* 
Program description: Find the best coordinate graph trail

Input x coordinates with y settings
As an example, 4 coordinates with 3 settings:
233.53.444, 234.55.364, 234.454.353, 344.467.976
We get 4 coordinates that have 3 settings, or 3 definitions.
If it were 5 definitions, it would be like this: 2348.342.4345.2344.233
Each "setting" is separated by a period sign
A coordinate graph trail is defined where a line passes through every node
In this case a node is a specific coordinate setting
A line can be made and the "weight" of the line is determined
by the absolute value of the difference of the preceding node, and the destination node
Meaning, the absolute value difference of the value of the node you're at and the value of the node you are going to
Note, 233 -> 244 will be the same as 244 -> 233 because |233-244| = |244-233|
A line's "weight" will never be negative
A coordinate graph rating is given by adding all of the line's weights
The "best" coordinate graph trail is the biggest (numerically) coordinate graph rating
There may be multiple "best" coordinate graph trails
To accommodate, the "best best" coordinate graph trail is
the trail which has the most well ordered weight based graph
meaning, the line's weight to a previous node pair is smaller than the
current line's weight in a given node pair.
Example, we would want 2,5,1 instead of 1,5,2.
Both have the same rating of 4 but 5,4,1's weights are |5-4|, |4-1| = 1, 3
Whereas 4,1,5 is |4-1|, |1-5| = 3, 1 which is not well ordered, not in smallest to biggest order
Be sure to make a "best best" coordinate graph trail for each 
"setting" and then combine them. Look below for a simple example:

Example input:
3 // Number of coordinates (n)
2 // Number of settings (s)

1.5 // coordinate 1 (int1.int2.int3. ...)
5.2 // coordinate 2
6.1 // coordinate 3

Possible example outputs:

1.5 -> 5.2 -> 6.1
5.2 -> 1.5 -> 6.1
6.5 -> 5.2 -> 1.1

Actual example output:

5.2 -> 1.5 -> 6.1

Explanation:
We have found that the above is the best coordinate graph trail
Let's check this, starting with setting 1 set A = {5, 1, 6}
From this given set A, we order it to find the biggest rating
5 -> 1 -> 6 has weights 4 and 5 respectively giving us our rating
which is 9. Trust me, this is the highest rating if we look at 
all graph combinations. Now, there is a different combination which is
6 -> 1 -> 5 which also has a rating of 9. Why didn't we use this rating?
This doesn't follow our second rule, the weight's have to be well ordered.
The weight of 6 -> 1 -> 5 are 5 and 4 respectively. 5 !< 4 so
it is not well ordered. Therefore the best coordinate graph trail
for setting 1 is 5 -> 1 -> 6.
For setting 2, we get another set B = {2, 5, 1}
2 -> 5 -> 1 has weights 3 and 4 respectively giving us a rating of
7. This is the highest rating for these possible numbers in set B.
The best coordinate graph trail for setting 2 is 2 -> 5 -> 1.
Finally we combine both settings to their corresponding positions, 
setting 1.setting 2, 5.2 -> 1.5 -> 6.1

Rules:
0 < number of coordinates < 1000
2 <= number of settings < 100
0 <= individual setting value <= 999999999
Only 1 output
Only allowed to use <stdio.h>, <stdlib.h> and <iostream> libraries
c or c++ only, exceptions can be made but ensure that no third-party library is used in the respective language choice
Input can be gotten from command line arguments or text file
Output must be in a text file named: graph_out.txt

Final Note:
The coordinate graph trail will be a LINEAR simple graph (see graph theory for further information)
There are no loops in the graph,
A node will have a value itself, which will be the value of the specific setting.
A line connecting some nodes will also have a value which is equivalent to |Node_I - Node_J| called the "weight"
We take the absolute value of this difference just to make it simple and not create more complexity
Be creative and smart, we can have up to 1000 coordinates.
At first, to figure out the best weight, you may have to go
through every number arrangement from a given set of numbers.
The permutation of 1000 different numbers, meaning the number of ways that 1000 different numbers can be arranged
is equivalent to 1000! (factorial). This number has 2568 digits, so searching through every
combination is not a good idea. Use a sophisticated algorithm for a simple and time-efficient program.

*/  

#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <limits.h>

typedef struct coordinateSet {
	unsigned int coordinateNum;
	unsigned int settingNum;
    int** coordinates;
} coordinateSet;

typedef struct linGraph {
	unsigned int v;
	int* nodes;
	int* weights;
} linGraph;

// coordinate constructors and functions
coordinateSet allocateCoordinateSet(unsigned int coordinateNum, unsigned int settingNum);
void freeCoordinateSet(coordinateSet* c);
void freeCoordinateSetDeep(coordinateSet* c);
unsigned int coordinateIdentifier(char* filename);
unsigned int settingIdentifier(char* filename);
coordinateSet newCoordSet(char* filename);
int charPtrToInt(char* c, int size);
int* coordinateSeperation(coordinateSet* c, int idx);

// graph constructors
linGraph allocateGraph(unsigned int v);
linGraph coordinatesToGraph(int* arr, int size);
void freeGraph(linGraph* g);

// algorithms

// restrictions set by challenge 
#define MAX_COORDINATES 1000
#define MAX_SETTINGS 100
#define MAX_VALUE 999999999

const coordinateSet INVALID = { 0, 0, 0 };

int main()
{
	// testing
	coordinateSet c = newCoordSet("trails.txt");

	for (unsigned int i = 0; i < c.coordinateNum; i++)
	{
		for (unsigned int j = 0; j < c.settingNum; j++)
		{
			printf("c[%d][%d] = %d\n", i, j, c.coordinates[i][j]);
		}
	}

	printf("\n");

	for (unsigned int i = 0; i < c.settingNum; i++)
	{
		int* arr = coordinateSeperation(&c, i);
		linGraph g = coordinatesToGraph(arr, c.coordinateNum);
		for (unsigned int j = 0; j < g.v; j++)
		{
			printf("%d -> ", g.nodes[j]);
		}
		printf("\n");
		for (unsigned int j = 0; j < g.v - 1; j++)
		{
			printf("%d, ", g.weights[j]);
		}
		printf("\n\n");
		freeGraph(&g);
		free(arr);
	}

	freeCoordinateSetDeep(&c);

	return 0;
}

/* 
	Allocate a coordinateSet structure
	Parameters: 
	- (unsigned int) settingNum which is the amount of numbers in a single coordinate, visually seperated by a period sign, think ip addresses
	- (unsigned int) coordinateNum which is the total number of coordinates

	Returns an empty coordinateSet structure
*/
coordinateSet allocateCoordinateSet(unsigned int settingNum, unsigned int coordinateNum)
{
	coordinateSet ret;
	ret.settingNum = settingNum;
	ret.coordinateNum = coordinateNum;
	// allocate coordinateSet
	ret.coordinates = malloc(coordinateNum * sizeof(int*));
	for (unsigned int i = 0; i < coordinateNum; i++)
	{
		// allocate for individual elements in a single coordinate
		ret.coordinates[i] = malloc(settingNum * sizeof(int));
	}
	return ret;
}

/*
	Frees a coordinateSet structure
	Parameter:
	- (coordinateSet*) c 

	Returns nothing
*/
void freeCoordinateSet(coordinateSet* c)
{
	free(c->coordinates);
	c->settingNum = 0;
	c->coordinateNum = 0;
}

/*
	Frees all values in individual coordinates in a coordinateSet structure
	Paremeter:
	- (coordinateSet*) c

	Returns nothing
*/
void freeCoordinateSetDeep(coordinateSet* c)
{
	for (unsigned int i = 0; i < c->coordinateNum; i++)
	{
		free(c->coordinates[i]);
	}

	freeCoordinateSet(c);
}


/*
	Evaluates the total number of coordinates in a text file
	Parameter:
	- (char *) filename which is the name of the text file

	Returns an unsigned int value
*/
unsigned int coordinateIdentifier(char* filename)
{
	// open the text file
	FILE* f = fopen(filename, "r");
	int ch = 0;
	unsigned int coordinateNum = 0;

	// base case to check if text file is empty
	if (f == NULL)
	{
		return 0;
	}

	// go through each character until we reach end of file
	while (ch != EOF)
	{
		ch = fgetc(f);
		// increment coordinateNum if we reach a new line
		if (ch == '\n')
		{
			coordinateNum++;
		}
	}
	fclose(f);

	// increment by 1 since last line is not counted
	return coordinateNum + 1;
}

/*
	Evaluates the number of settings in a single coordinate
	Parameter:
	- (char *) filename which is the name of the text file

	Returns an unsigned int value
*/
unsigned int settingIdentifier(char* filename)
{
	// open the text file
	FILE* f = fopen(filename, "r");
	int ch = 0;
	unsigned int settingNum = 0;
	unsigned int checker = 0;

	// base case
	if (f == NULL)
	{
		return 0;
	}

	// go through each character until we reach a new line
	while (ch != '\n')
	{
		ch = fgetc(f);
		// increment settingNum if we reach a period sign, which seperates a setting
		if (ch == '.')
		{
			settingNum++;
		}
	}

	while (ch != EOF)
	{
		ch = fgetc(f);
		// increment settingNum if we reach a period sign, which seperates a setting
		if (ch == '.')
		{
			checker++;
		}

		// check if all coordinates have the same amount of settings
		if (ch == '\n')
		{
			checker++;
			if (checker != settingNum + 1)
			{
				printf("Invalid stream, coordinates have varied sizes!\n");
				fclose(f);
				exit(EXIT_FAILURE);
			}
			checker = 0;
		}
	}

	fclose(f);

	// increment settingNum since there is no period sign at the last setting
	return settingNum + 1;
}

/*
	Creates a coordinateSet structure from a text file
	Parameter:
	- (char *) filename which is the name of the text file

	Returns a fully intilized coordinateSet structure
*/
coordinateSet newCoordSet(char* filename)
{
	unsigned int coordinateNum = 0;
	unsigned int settingNum = 0;

	// find number of coordinates by counting the number of lines in a file
	coordinateNum = coordinateIdentifier(filename);
	settingNum = settingIdentifier(filename);

	// base cases and restrictions
	if (coordinateNum > MAX_COORDINATES ||
		settingNum > MAX_SETTINGS ||
		settingNum < 2)
	{
		return INVALID;
	}

	// allocate return coordinateSet
	coordinateSet ret = allocateCoordinateSet(settingNum, coordinateNum);

	// open the text file
	FILE* f = fopen(filename, "r");
	int ch = '0';
	// allocate a currentNum char pointer to keep track of the current setting of a coordinate
	char* currentNum = malloc(1 * sizeof(char));
	// count to keep track of length of currentNum
	unsigned int count = 0;

	for (unsigned int i = 0; i < coordinateNum; i++)
	{
		for (unsigned int j = 0; j < settingNum; j++)
		{
			ch = fgetc(f);
			// set to 0 at beginning of loop and before every new setting we look at
			count = 0;
			currentNum = NULL;
			// reallocate for one character and the terminator
			currentNum = realloc(currentNum, (count + 1) * sizeof(char) + 1);
			// go thorugh each character of the text file until we reach a period sign, a new line or the end of the file
			while (ch != '.' && ch != '\n' && ch != EOF)
			{
				// check if we are currently looking at a number
				if (ch >= '0' && ch <= '9')
				{
					currentNum = (char*)realloc(currentNum, (count + 1) * sizeof(char) + 1);
					// set current pointer value to what we are looking at
					currentNum[count] = ch;
					count++;
				}

				// check for negative, deny if existing
				if (ch == '-')
				{
					printf("Unhandled negative signature\n");
					free(currentNum);
					freeCoordinateSetDeep(&ret);
					exit(EXIT_FAILURE);
				}

				ch = fgetc(f);
			}
			ret.coordinates[i][j] = charPtrToInt(currentNum, count);

			// number should be less than or equal to max value and overflow control
			if (ret.coordinates[i][j] > MAX_VALUE)
			{
				printf("number exceeds limit");
				free(currentNum);
				freeCoordinateSet(&ret);
				exit(EXIT_FAILURE);
			}
		}
	}

	// frees currentNum since we don't need it anymore
	free(currentNum);

	return ret;
}

/*
	Converts a char pointer to a long long integer
	Parameter:
	- (char *) c which is the char pointer that contains a number in string form

	Returns an unsigned long long integer that was combined from the char pointer
*/
int charPtrToInt(char* c, int size)
{
	int ret = 0;
	unsigned int count = 0;

	// iterate through pointer
	for (int i = size - 1; i >= 0; i--, count++)
	{
		// convert char to int using ASCII arithmetic
		ret += (c[count] - 48) * pow(10, i);
	}

	return ret;
}

/*
	Seperates numbers from each coordinate and is put into int array
	Parameter:
	- (coordinateSet *) c which is the coordinateSet structure
	- (int) idx which specifies the setting we want to seperate
	
	Returns an integer array
*/
int* coordinateSeperation(coordinateSet* c, int idx)
{
	if (idx > c->settingNum)
	{
		printf("SIGSEV requesting unbounded data\n");
		return -1;
	}

	int* ret = malloc(c->coordinateNum * sizeof(int));

	for (unsigned int i = 0; i < c->coordinateNum; i++)
	{
		ret[i] = c->coordinates[i][idx];
	}

	return ret;
}

/*
	Allocates a linear graph structure
	Parameter:
	- (unsigned int) v which is the number of vertices

	Returns a linear graph structure
*/
linGraph allocateGraph(unsigned int v)
{
	linGraph ret;
	ret.v = v;
	ret.nodes = malloc(v * sizeof(int));
	ret.weights = malloc((v - 1) * sizeof(int));

	return ret;
}

linGraph coordinatesToGraph(int* arr, int size)
{
	if (!arr)
	{
		return;
	}

	linGraph ret = allocateGraph(size);

	for (unsigned int i = 0; i < ret.v; i++)
	{
		ret.nodes[i] = arr[i]; 
		if (i > 0)
		{
			ret.weights[i - 1] = abs(arr[i] - arr[i - 1]);
		}
	}

	return ret;
}

void freeGraph(linGraph* g)
{
	g->v = 0;
	free(g->nodes);
	free(g->weights);
}