#include <stdio.h>
#include <stdint.h>

typedef enum {
  NoSolution,
  UniqueSolution,
  InfiniteSolutions
} diophantine_solution_type;

typedef struct {
  diophantine_solution_type result;
  int64_t x;
  int64_t y;
} diophantine_solution;

extern uint64_t factorial(uint64_t n);
extern uint64_t gcd(uint64_t a, uint64_t b);
extern diophantine_solution solve_diophantine(int64_t a, int64_t b, int64_t c);

int main() {
  printf("factorial(7) = %lu\n", factorial(7));
  printf("gcd(18, 12) = %lu\n", gcd(18, 12));
  diophantine_solution solution = solve_diophantine(12, 15, -9);
  printf("solve_diophatnine(12, 15, -9) = (%d, %ld, %ld)\n", solution.result, solution.x, solution.y);
  return 0;
}
