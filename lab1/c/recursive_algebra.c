#include "recursive_algebra.h"
#include <stdio.h>
uint64_t factorial(const uint64_t n) {
    if (n == 0) {
        return 1;
    }

    return n * factorial(n - 1);
}

uint64_t gcd(const uint64_t a, const uint64_t b) {
    const uint64_t m = a > b ? a : b;
    const uint64_t n = a > b ? b : a;

    if (n == 0) {
        return m;
    }

    return gcd(n, m % n);
}

diophantine_solution solve_diophantine(const int64_t a, const int64_t b, const int64_t c) {
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

    if(b == 0) {
        return (diophantine_solution) {.result = UniqueSolution, .x = c / a, .y = 0};
    }

    diophantine_solution solution = solve_diophantine(b, a % b, c);
    int64_t x = solution.x;
    int64_t y = solution.y;
    solution.x = y;
    solution.y = x - (a / b) * y;
    
    return solution;
}
