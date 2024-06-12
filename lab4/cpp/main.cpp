#include <iostream>
#include <thread>
#include <chrono>
#include <atomic>
#include <random>

constexpr size_t MIN_DELAY = 20;
constexpr size_t MAX_DELAY = 50;

size_t randomNumber(size_t min, size_t max) {
    static std::mt19937 gen{std::random_device{}()};
    std::uniform_int_distribution<size_t> dis(min, max);
    return dis(gen);
}

void lock(std::atomic<int>& mutex) {
  while(mutex);
  mutex=1;
}

void unlock(std::atomic<int>& mutex) {
  mutex=0;
}

void runPhilosopher(size_t id, size_t mealsNumber, std::atomic<int>& leftFork, std::atomic<int>& rightFork) {
    size_t meals = 0;
    while(meals < mealsNumber) {
        size_t thinkDuration = randomNumber(MIN_DELAY, MAX_DELAY);
        std::cout << "Philosopher " << id << " is thinking" << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(thinkDuration));

        lock(leftFork);
        std::cout << "Philosopher " << id << " got left fork" << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(MIN_DELAY));

        lock(rightFork);
        std::cout << "Philosopher " << id << " got right fork" << std::endl;

        size_t eatDuration = randomNumber(MIN_DELAY, MAX_DELAY);
        std::cout << "Philosopher " << id << " is eating " << meals << " lunch" << std::endl;
        std::this_thread::sleep_for(std::chrono::milliseconds(eatDuration));

        meals++;

        unlock(rightFork);
        unlock(leftFork);
    }
}

int main(int argc, char *argv[]) {
    if(argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <number of philosophers> <number of meals>" << std::endl;
        return 1;
    }

    size_t philosophersNumber;
    try {
        philosophersNumber = std::stoi(argv[1]);
    } catch(std::invalid_argument &e) {
        std::cerr << "Invalid number of philosophers: " << argv[1] << std::endl;
        return 1;
    }

    size_t mealsNumber;
    try {
        mealsNumber = std::stoi(argv[2]);
    } catch(std::invalid_argument &e) {
        std::cerr << "Invalid number of meals: " << argv[2] << std::endl;
        return 1;
    }

    std::vector<std::atomic<int>> forks(philosophersNumber);
    for(size_t i = 0; i < philosophersNumber; i++) {
        forks[i] = 0;
    }

    std::vector<std::thread> philosophers(philosophersNumber);
    for(size_t i = 0; i < philosophersNumber; i++) {
        philosophers[i] = std::thread([&] {runPhilosopher(i, mealsNumber, forks[i], forks[(i + 1) % philosophersNumber]);});
    }

    for(size_t i = 0; i < philosophersNumber; i++) {
        philosophers[i].join();
    }
}