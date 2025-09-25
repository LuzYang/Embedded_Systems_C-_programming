#include <iostream>
#include <map>
using namespace std;

int main() {
    
    map<string, double> weather = {
        {"Mon", 5.5},
        {"Tue", 12.3},
        {"Wed", 18.0},
        {"Thu", 21.4},
        {"Fri", 9.9},
        {"Sat", 15.2},
        {"Sun", 23.5}
    };

    
    char condition = 'S'; // Sunny

    double sum = 0;
    for (auto& entry : weather) {
        cout << entry.first << ": " << entry.second << "deg C (" << condition << ")" << endl;
        sum += entry.second;
    }

    double avg = sum / weather.size();
    cout << "\nAverage temperature: " << avg << " deg C\n";

    return 0;
}
