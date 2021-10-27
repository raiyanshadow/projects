#include <iostream>
#include <vector>
#include <algorithm>
#include <string>

using namespace std;

vector<int> str_to_int(string a);
int shortest_sorts(vector<int> a, int b);


int main()
{
    string st1;
    cin >> st1;
	
	int a = st1.size();
	vector<int> num = str_to_int(st1);
	st2 = int_to_str(num, a);
   
	cout << shortest_sorts(num, a) << "\n\n";

	return 0;
}

vector<int> str_to_int(string a)
{
    vector<int> ret;
    for (int i = 0; i < a.size(); i++)
    {
        if (a[i] == 'L')
            ret.push_back(2);
        else if (a[i] == 'M') 
            ret.push_back(1);
        else 
            ret.push_back(0);
    }
    return ret;
}

int shortest_sorts(vector<int> a, int b)
{
    bool x = false;
	int swaps = 0;

	for (int i = 1; i < b; i++)
	{
		x = (a.at(i) <= a.at(i-1)) ? true : false;
		if (x == true && i == b-1)
		{
			return swaps;
		}
		else if (x == true)
		{
			continue;
		}
		else
		{
			for (int j = 1; j < b; j++)
			{
				if (a.at(i) > a.at(j))
				{
					swap(a.at(i), a.at(j));
					swaps++;
					break;
				}
			}
			i = 1;
		}
	}	
	
    return swaps;
}
