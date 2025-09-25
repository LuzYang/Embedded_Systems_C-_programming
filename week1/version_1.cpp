#include <iostream>
#include <vector>
#include <tuple>
using namespace std;

int main() {
    
    vector<string> days = {"Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"};
    vector<double> temps = {5.5, 12.3, 18.0, 21.4, 9.9, 15.2, 23.5};

    
    for (size_t i = 0; i < days.size(); i++) {
        cout << days[i] << ": " << temps[i] << " deg C - ";
        if (temps[i] < 10) cout << "Cold";
        else if (temps[i] <= 20) cout << "Ok";
        else cout << "Warm";
        cout << endl;
    }

    
    double maxTemp = temps[0];
    string warmestDay = days[0];

    for (size_t i = 1; i < temps.size(); i++) {
        if (temps[i] > maxTemp) {
            maxTemp = temps[i];
            warmestDay = days[i];
        }
    }

    tuple<string, double> warmest = make_tuple(warmestDay, maxTemp);
    cout << "\nWarmest day: " << get<0>(warmest) << " with " << get<1>(warmest) << " deg C\n";

    return 0;
}
