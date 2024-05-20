#[derive(Debug)]
#[repr(C)]
pub enum diophantine_solution_type {
    NoSolution = 0,
    UniqueSolution = 1,
    InfiniteSolution = 2
}

#[derive(Debug)]
#[repr(C)]
pub struct diophantine_solution {
    result: diophantine_solution_type,
    x: i64,
    y: i64
}

#[link(name = "iterative_algebra")]
extern "C" {
    pub fn factorial(n: u64) -> u64;
    pub fn gcd(a: u64, b: u64) -> u64;
    pub fn solve_diophantine(a: i64, b: i64, c:i64) -> diophantine_solution;
}

fn main() {
    let n = 7;
    let f = unsafe { factorial(n) };
    println!("factorial of {} is {}", n, f);

    let a = 12;
    let b = 18;
    let g = unsafe { gcd(a, b) };
    println!("gcd of {} and {} is {}", a, b, g);

    let a = 12;
    let b = 15;
    let c = -9;
    let s = unsafe { solve_diophantine(a, b, c) };
    println!("solution of {}x + {}y = {} is type {:?} x = {}, y = {}", a, b, c, s.result, s.x, s.y);
}
