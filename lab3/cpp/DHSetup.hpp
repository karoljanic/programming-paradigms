#pragma once 

#include "GaloisFieldConcept.hpp"

#include <random>

template <GaloisFieldConcept<uint64_t> T>
class DHSetup {
public:
    DHSetup() {
        static std::mt19937 gen32{std::random_device{}()};
        static std::uniform_int_distribution<uint32_t> uniform{1, static_cast<unsigned int>(T::getCharacteristic() - 1)};

        const auto primeDivisors = DHSetup::generatePrimeDivisors(T::getCharacteristic() - 1);

        do {
            generator = T{uniform(gen32)};
        } while (not DHSetup::isValidGenerator(generator, primeDivisors));
    }

    DHSetup(const DHSetup&) = default;
    DHSetup(DHSetup&&) = default;

    DHSetup& operator=(const DHSetup&) = default;
    DHSetup& operator=(DHSetup&&) = default;

    ~DHSetup() = default;

    T getGenerator() const noexcept {
        return generator;
    }

    static T power(T base, uint64_t exponent) noexcept {
        T result = 1;
        if (exponent == 0) {
            return result;
        }

        while (exponent > 1) {
            if (exponent % 2 != 0) {
                result *= base;
                exponent--;
            }

            base *= base;
            exponent /= 2;
        }

        return result * base;
    }

private:
     static std::vector<uint32_t> generatePrimeDivisors(uint32_t n) noexcept {
        std::vector<uint32_t> prime_divisors;

        for (uint32_t i = 2; i * i <= n; i++) {
            if (n % i == 0) {
                prime_divisors.push_back(i);
                while (n % i == 0)
                    n /= i;
            }
        }

        return prime_divisors;
    }

     static bool isValidGenerator(const T& candidate, const std::vector<uint32_t>& primeDivisors) noexcept {
        for (const auto p : primeDivisors) {
            if (DHSetup::power(candidate, (T::getCharacteristic() - 1) / p) == T{1u}) {
                return false;
            }
        }

        return true;
    }

    T generator;
};