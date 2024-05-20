mod iterative_algebra;

use iterative_algebra::factorial;
use iterative_algebra::gcd;
use iterative_algebra::solve_diophantine;
use iterative_algebra::DiophantineSolution;
use iterative_algebra::DiophantineSolutionType;

fn test_factorial(n: u64, expected: u64) {
    let result: u64 = factorial(n);
    if result != expected {
        println!("FAILED: factorial({}) = {}, expected {}", n, result, expected);
    }
    else {
        println!("PASSED: factorial({}) = {}", n, result);
    }
}

fn test_gcd(a: u64, b: u64, expected: u64) {
    let result: u64 = gcd(a, b);
    if result != expected {
        println!("FAILED: gcd({}, {}) = {}, expected {}", a, b, result, expected);
    }
    else {
        println!("PASSED: gcd({}, {}) = {}", a, b, result);
    }
}

fn test_diophantine(a: i64, b: i64, c: i64, expected: DiophantineSolution) {
    let result: DiophantineSolution = solve_diophantine(a, b, c);
    if result != expected {
        println!("FAILED: solve_diophantine({}, {}, {}) = {:?}, expected {:?}", a, b, c, result, expected);
    }
    else {
        println!("PASSED: solve_diophantine({}, {}, {}) = {:?}", a, b, c, result);
    }
}

fn main() {
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
    test_diophantine(0, 0, 0, DiophantineSolution{solution_type: DiophantineSolutionType::InfiniteSolutions, x: 0, y: 0});
    test_diophantine(0, 0, 1, DiophantineSolution{solution_type: DiophantineSolutionType::NoSolution, x: 0, y: 0});
    test_diophantine(12, 15, 3, DiophantineSolution{solution_type: DiophantineSolutionType::UniqueSolution, x: -1, y: 1});
    test_diophantine(12, 15, -3, DiophantineSolution{solution_type: DiophantineSolutionType::UniqueSolution, x: 1, y: -1});
    test_diophantine(12, 15, -9, DiophantineSolution{solution_type: DiophantineSolutionType::UniqueSolution, x: 3, y: -3});
    test_diophantine(12, 15, 4, DiophantineSolution{solution_type: DiophantineSolutionType::NoSolution, x: 0, y: 0});
}
