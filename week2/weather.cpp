#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <stdexcept>
#include <iomanip>
#include <vector>
#include <numeric>

class WeatherStation {
private:
    std::string location;
    float* readings;      // dynamic array
    size_t size;          // number of readings stored
    size_t capacity;      // allocated capacity

    // Helper to ensure we have enough capacity
    void ensureCapacity(size_t minCapacity) {
        if (capacity >= minCapacity) return;
        size_t newCap = std::max(capacity * 2, minCapacity);
        float* newArr = new float[newCap];
        for (size_t i = 0; i < size; ++i) newArr[i] = readings[i];
        delete[] readings;
        readings = newArr;
        capacity = newCap;
    }

public:
    // Constructor
    WeatherStation(const std::string& loc = "", size_t initial_capacity = 4)
        : location(loc), readings(nullptr), size(0), capacity(0) {
        if (initial_capacity == 0) initial_capacity = 4;
        readings = new float[initial_capacity];
        capacity = initial_capacity;
    }

    // Copy constructor (deep copy)
    WeatherStation(const WeatherStation& other)
        : location(other.location), readings(nullptr), size(other.size), capacity(other.capacity) {
        readings = new float[capacity];
        for (size_t i = 0; i < size; ++i) readings[i] = other.readings[i];
    }

    // Copy assignment (deep copy)
    WeatherStation& operator=(const WeatherStation& other) {
        if (this == &other) return *this;
        delete[] readings;
        location = other.location;
        size = other.size;
        capacity = other.capacity;
        readings = new float[capacity];
        for (size_t i = 0; i < size; ++i) readings[i] = other.readings[i];
        return *this;
    }

    // Destructor
    ~WeatherStation() {
        delete[] readings;
    }

    // Add a new temperature reading (uses new[] to resize when necessary)
    void addReading(float value) {
        if (size + 1 > capacity) {
            ensureCapacity(capacity == 0 ? 4 : capacity * 2);
        }
        readings[size++] = value;
    }

    // Print readings in insertion order
    void printReadings() const {
        std::cout << "Location: " << location << std::endl;
        std::cout << "Readings: ";
        for (size_t i = 0; i < size; ++i) {
            std::cout << readings[i];
            if (i + 1 < size) std::cout << " ";
        }
        std::cout << std::endl;
    }

    // Save readings to file (throws on I/O error)
    void saveToFile(const std::string& filename) const {
        std::ofstream ofs(filename, std::ios::trunc);
        if (!ofs) throw std::ios_base::failure("Failed to open file for writing: " + filename);

        // Simple file format:
        // first line: location
        // second line: number of readings
        // third line: readings separated by spaces
        ofs << location << '\n';
        ofs << size << '\n';
        for (size_t i = 0; i < size; ++i) {
            ofs << readings[i];
            if (i + 1 < size) ofs << ' ';
        }
        ofs << '\n';

        // check for write errors
        if (!ofs) throw std::ios_base::failure("Failed to write to file: " + filename);
    }

    // Load from file and reconstruct a WeatherStation object (throws on error)
    static WeatherStation loadFromFile(const std::string& filename) {
        std::ifstream ifs(filename);
        if (!ifs) throw std::ios_base::failure("Failed to open file for reading: " + filename);

        std::string loc;
        if (!std::getline(ifs, loc)) throw std::ios_base::failure("Failed to read location from file: " + filename);

        size_t count = 0;
        if (!(ifs >> count)) throw std::ios_base::failure("Failed to read count from file: " + filename);

        WeatherStation ws(loc, std::max<size_t>(4, count));
        // consume the endline after count so we can read floats using >> safely
        // (not strictly necessary since >> skips whitespace)

        for (size_t i = 0; i < count; ++i) {
            float v;
            if (!(ifs >> v)) throw std::ios_base::failure("Failed to read reading #" + std::to_string(i + 1) + " from file: " + filename);
            ws.addReading(v);
        }

        return ws; // uses copy elision / move
    }

    // Count readings above a threshold using STL algorithm
    size_t countAbove(float threshold) const {
        return static_cast<size_t>(std::count_if(readings, readings + size, [threshold](float v) { return v > threshold; }));
    }

    // Return a sorted copy of readings (uses STL sort)
    std::vector<float> getSortedReadings() const {
        std::vector<float> copy(readings, readings + size);
        std::sort(copy.begin(), copy.end());
        return copy;
    }

    // Template to calculate average; prevents division by zero by throwing
    template <typename T>
    static double calculateAverage(const T* arr, size_t n) {
        if (n == 0) throw std::runtime_error("Cannot calculate average for zero elements");
        double sum = 0.0;
        for (size_t i = 0; i < n; ++i) sum += static_cast<double>(arr[i]);
        return sum / static_cast<double>(n);
    }

    // Convenience wrapper
    double average() const {
        return calculateAverage<float>(readings, size);
    }
};

int main() {
    try {
        WeatherStation ws("Lahti");
        // add sample readings
        ws.addReading(22.5f);
        ws.addReading(24.0f);
        ws.addReading(26.3f);
        ws.addReading(21.8f);
        ws.addReading(25.7f);

        // print readings
        ws.printReadings();

        // average (template protects against division by zero)
        double avg = ws.average();
        std::cout << "Average: " << std::fixed << std::setprecision(2) << avg << std::endl;

        // count above 25C using STL
        size_t above25 = ws.countAbove(25.0f);
        std::cout << "Readings above 25 degrees C: " << above25 << std::endl;

        // demonstrate sorting (we do not mutate original readings; get a sorted copy)
        auto sorted = ws.getSortedReadings();
        // (optional) print sorted values - commented out to match sample output order
        // std::cout << "Sorted: "; for (auto v : sorted) std::cout << v << " "; std::cout << std::endl;

        // save to file
        const std::string filename = "lahti_readings.txt";
        ws.saveToFile(filename);
        std::cout << "Saved to file: " << filename << std::endl;

        // reconstruct from file
        WeatherStation ws2 = WeatherStation::loadFromFile(filename);
        std::cout << "\nReconstructed from file:" << std::endl;
        ws2.printReadings();

    } catch (const std::exception& ex) {
        std::cerr << "Error: " << ex.what() << std::endl;
        return 1;
    }

    return 0;
}
