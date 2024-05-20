#[derive(Debug)]
#[repr(C)]
pub enum DiophantineSolutionType {
    NoSolution,
    UniqueSolution,
    InfiniteSolutions
}

impl PartialEq for DiophantineSolutionType {
    fn eq(&self, other: &Self) -> bool {
        match (self, other) {
            (DiophantineSolutionType::NoSolution, DiophantineSolutionType::NoSolution) => true,
            (DiophantineSolutionType::UniqueSolution, DiophantineSolutionType::UniqueSolution) => true,
            (DiophantineSolutionType::InfiniteSolutions, DiophantineSolutionType::InfiniteSolutions) => true,
            _ => false,
        }
    }
}

#[derive(Debug)]
#[repr(C)]
pub struct DiophantineSolution {
    pub solution_type: DiophantineSolutionType,
    pub x: i64,
    pub y: i64,
}

impl PartialEq for DiophantineSolution {
    fn eq(&self, other: &Self) -> bool {
        self.solution_type == other.solution_type && self.x == other.x && self.y == other.y
    }
}

#[no_mangle]
pub extern "C" fn factorial(n: u64) -> u64 {
    if n == 0 {
        return 1;
    }

    return n * factorial(n - 1);
}

#[no_mangle]
pub extern "C" fn gcd(a: u64, b: u64) -> u64 {
    let m: u64 = if a > b { a } else { b };
    let n: u64 = if a > b { b } else { a };

    if n == 0 {
        return m;
    }

    return gcd(n, m % n);
}

#[no_mangle]
pub extern "C" fn solve_diophantine(a: i64, b: i64, c: i64) -> DiophantineSolution {
    let positive_a: i64 = if a < 0 { -a } else { a };
    let positive_b: i64 = if b < 0 { -b } else { b };
    let positive_c: i64 = if c < 0 { -c } else { c };
    let gcd_ab: i64 = gcd(positive_a as u64, positive_b as u64) as i64;

    if gcd_ab == 0 {
        if c == 0 {
            return DiophantineSolution {
                solution_type: DiophantineSolutionType::InfiniteSolutions,
                x: 0,
                y: 0,
            };
        } else {
            return DiophantineSolution {
                solution_type: DiophantineSolutionType::NoSolution,
                x: 0,
                y: 0,
            };
        }
    }

    if positive_c % gcd_ab != 0 {
        return DiophantineSolution {
            solution_type: DiophantineSolutionType::NoSolution,
            x: 0,
            y: 0,
        };
    }

    if b == 0 {
        return DiophantineSolution {
            solution_type: DiophantineSolutionType::UniqueSolution,
            x: c / a,
            y: 0,
        };
    }

    let mut solution: DiophantineSolution = solve_diophantine(b, a % b, c);
    let x: i64 = solution.x;
    let y: i64 = solution.y;
    solution.x = y;
    solution.y = x - (a / b) * y;

    return solution;
}
