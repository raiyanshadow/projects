#include <iostream>
#include <vector>
#include <string>
#include <cmath>

#define NUMLEN 5
#define END 99999

using namespace std;

#pragma warning( push )
#pragma warning( disable : 4101)

int main()
{
    vector<int> nums = {};
    int a = 0;
    int s = 0;
    
    do
    {
        cin >> s;
        nums.push_back(s);
        a++;
    }
    while (s != END);
    
    cout << "\n";
    vector<string> dir (a+1);
    int x, y, z = 0;
    string st = "right";
    
    for (int i = 0; i < a-1; i++)
    {
         z = nums.at(i) / 1000;
         x = z / 10;
         y = z % 10;
         if (x + y == 0)
         {
             dir.at(i) = st;
         }
         dir.at(i) = ((int) floor(x + y) % 2 == 0) ? "right" : "left";
         st = dir.at(i);
         cout << dir.at(i) << ' ' << nums.at(i) % 1000 << "\n"; 
    }
}

#pragma warning( pop )
