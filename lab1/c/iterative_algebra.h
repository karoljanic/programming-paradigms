#ifndef ITERATIVE_ALGEBRA_H
#define ITERATIVE_ALGEBRA_H

#include <stdint.h>

typedef enum {
  NoSolution,
  UniqueSolution,
  InfiniteSolutions
} diophantine_solution_type;

typedef struct diophantine_solution {
  diophantine_solution_type result;
  int64_t x;
  int64_t y;
} diophantine_solution;

uint64_t factorial(const uint64_t);
uint64_t gcd(const uint64_t, const uint64_t);
diophantine_solution solve_diophantine(const int, const int,
                                       const int);

#endif  // ITERATIVE_ALGEBRA_H