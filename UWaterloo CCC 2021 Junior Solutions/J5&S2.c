#include<iostream>
#include<vector>

using namespace std;

int main()
{
    int a, b, c, d;
    char e;
    cin >> a;
    cin >> b;
    cin >> c;
    vector<vector<int>> adj(a, vector<int>(b));
    vector<char> mode(c);
    vector<int> coord(c);
    
    for (int i = 0; i < a; i++)
    {
        for (int j = 0; j < b; j++)
        {
            adj[i][j] = 0;          // 0 = black, 1 = gold
        }
    }
    
    for (int i = 0; i < c; i++)
    {
        cin >> e >> d;
        mode[i] = e;
        coord[i] = d;
    }
    
    int count = 0;
    
    for (int i = 0; i < c; i++)
    {
        if (mode[i] == 'R')
        {
            for (int  j = 0; j < b; j++)
            {
                adj[coord[i]-1][j] = (adj[coord[i]-1][j] == 0) ? 1 : 0;
            }
        }
        else if (mode[i] == 'C')
        {
            for (int  j = 0; j < a; j++)
            {
                adj[j][coord[i]-1] = (adj[j][coord[i]-1] == 0) ? 1 : 0;
            }
        }
    }

    for (int  i = 0; i < a; i++)
    {
        for (int j = 0; j < b; j++)
        {
            count += (adj[i][j] == 1) ? 1 : 0;
        }
    }
    cout << "\n" << count;
    
    return 0;
}