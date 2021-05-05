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
7. Again, take my word, it is the highest rating for these possible numbers in set B.
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
There are no loops in the graph, it is just from Node A to Node Z or whatever letter it ends at
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

#import <stdio.h>
#import <stdlib.h>
#import <iostream>

using namespace std

int main()
{
	return 0;
}