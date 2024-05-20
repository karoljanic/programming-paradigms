#ifdef RECURSIVE_VERSION
#include "iterative_algebra.h"
#else
#include "recursive_algebra.h"
#endif

#include <stdio.h>
#include <stdint.h>

void test_factorial(uint64_t n, uint64_t expected) {
    uint64_t result = factorial(n);
    if (result != expected) {
        printf("FAILED: factorial(%lu) = %lu, expected %lu\n", n, result, expected);
    }
    else {
        printf("PASSED: factorial(%lu) = %lu\n", n, result); 
    }
}

void test_gcd(uint64_t a, uint64_t b, uint64_t expected) {
    uint64_t result = gcd(a, b);
    if (result != expected) {
        printf("FAILED: gcd(%lu, %lu) = %lu, expected %lu\n", a, b, result, expected);
    }
    else {
        printf("PASSED: gcd(%lu, %lu) = %lu\n", a, b, result); 
    }
}

void test_diophantine(int64_t a, int64_t b, int64_t c, diophantine_solution expected) {
    diophantine_solution result = solve_diophantine(a, b, c);
    if (result.result != expected.result || result.x != expected.x || result.y != expected.y) {
        printf("FAILED: solve_diophantine(%ld, %ld, %ld) = {%d, %ld, %ld}, expected {%d, %ld, %ld}\n", a, b, c, result.result, result.x, result.y, expected.result, expected.x, expected.y);
    }
    else {
        printf("PASSED: solve_diophantine(%ld, %ld, %ld) = {%d, %ld, %ld}\n", a, b, c, result.result, result.x, result.y); 
    }
}

int main(void) {
    // Test factorial
    test_factorial(0, 1);
    test_factorial(1, 1);
    test_factorial(2, 2);
    test_factorial(7, 5040);
    test_factorial(12, 479001600);

    // Test gcd
    test_gcd(0, 0, 0);
    test_gcd(0, 1, 1);
    test_gcd(1, 0, 1);
    test_gcd(1, 1, 1);
    test_gcd(4, 6, 2);
    test_gcd(12, 18, 6);
    test_gcd(18, 12, 6);
    test_gcd(17, 120, 1);

    // Test diophantine_solution
    test_diophantine(0, 0, 0, (diophantine_solution) {.result = InfiniteSolutions, .x = 0, .y = 0});
    test_diophantine(0, 0, 1, (diophantine_solution) {.result = NoSolution, .x = 0, .y = 0});
    test_diophantine(12, 15, 3, (diophantine_solution) {.result = UniqueSolution, .x = -1, .y = 1});
    test_diophantine(12, 15, -3, (diophantine_solution) {.result = UniqueSolution, .x = 1, .y = -1});
    test_diophantine(12, 15, -9, (diophantine_solution) {.result = UniqueSolution, .x = 3, .y = -3});
    test_diophantine(12, 15, 4, (diophantine_solution) {.result = NoSolution, .x = 0, .y = 0});

    return 0;
}
