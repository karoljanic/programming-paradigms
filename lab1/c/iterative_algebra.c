#include "iterative_algebra.h"

uint64_t factorial(const uint64_t n) {
    uint64_t result = 1;

    for (uint64_t i = 1; i <= n; i++) {
        result *= i;
    }

    return result;
}

uint64_t gcd(const uint64_t a, const uint64_t b) {
    uint64_t m = a > b ? a : b;
    uint64_t n = a > b ? b : a;

    while (n > 0) {
        uint64_t temp = n;
        n = m % n;
        m = temp;
    }

    return m;
}

diophantine_solution solve_diophantine(const int a, const int b, const int c) {
    int64_t positive_a = a < 0 ? -a : a;
    int64_t positive_b = b < 0 ? -b : b;
    int64_t positive_c = c < 0 ? -c : c;
    int64_t gcd_ab = gcd(positive_a, positive_b);

    if (gcd_ab == 0) {
        if(c == 0) {
            return (diophantine_solution) {.result = InfiniteSolutions, .x = 0, .y = 0};
        } else {
            return (diophantine_solution) {.result = NoSolution, .x = 0, .y = 0};
        }
    }

    if(positive_c % gcd_ab != 0) {
        return (diophantine_solution) {.result = NoSolution, .x = 0, .y = 0};
    }

    int64_t a_copy = a;
    int64_t b_copy = b;
    int64_t x1 = 0;
    int64_t y1 = 1;
    int64_t x2 = 1;
    int64_t y2 = 0;

    while (b_copy != 0) {
        int64_t q = a_copy / b_copy;
        int64_t r = a_copy % b_copy;
        int64_t x_tmp, y_tmp;

        x_tmp = x2 - q * x1;
        y_tmp = y2 - q * y1;
        a_copy = b_copy;
        b_copy = r;
        x2 = x1;
        y2 = y1;
        x1 = x_tmp;
        y1 = y_tmp;
    }

    return (diophantine_solution) {.result = UniqueSolution, .x = x2 * (c / gcd_ab), .y = y2 * (c / gcd_ab)};
}
