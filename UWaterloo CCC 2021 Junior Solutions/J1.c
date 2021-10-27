#include <iostream>

using namespace std;

int main()
{
    int x, y, z;
    cin >> x;
    
    y = 5 * x - 400;
    
    if (y == 100) {
       z = 0; 
    }
    else {
        z = (y > 100) ? -1 : 1;
    }
    
    cout << y << "\n" << z;
}
