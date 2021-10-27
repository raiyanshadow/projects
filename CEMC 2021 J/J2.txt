#include <iostream>
#include <string>
#include <vector>
#include <algorithm>

using namespace std;

int main()
{
    int x;
    cin >> x;
    
    vector<string> candidates (x);
    vector<int> pointsv (x);
    int points[x] = {};
    
    for (int  i = 0; i < x; i++)
    {
        cin >> candidates.at(i);
        cin >> pointsv.at(i);
        points[i] = pointsv.at(i);
    }
    
    cout << "\n" << candidates.at(max_element(points, points + x) - points);
}