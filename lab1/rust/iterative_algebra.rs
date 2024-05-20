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
    let mut result: u64 = 1;
    for i in 1..n + 1 {
        result *= i;
    }
    return result;
}

#[no_mangle]
pub extern "C" fn gcd(a: u64, b: u64) -> u64 {
    let mut n: u64 = if a > b { a } else { b };
    let mut m: u64 = if a > b { b } else { a };

    while n != 0 {
        let temp: u64 = n;
        n = m % n;
        m = temp;
    }

    return m;
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

    let mut a_copy: i64 = a;
    let mut b_copy: i64 = b;
    let mut x1: i64 = 0;
    let mut y1: i64 = 1;
    let mut x2: i64 = 1;
    let mut y2: i64 = 0;

    while b_copy != 0 {
        let q: i64 = a_copy / b_copy;
        let r: i64 = a_copy % b_copy;
        let x: i64 = x2 - q * x1;
        let y: i64 = y2 - q * y1;
        a_copy = b_copy;
        b_copy = r;
        x2 = x1;
        x1 = x;
        y2 = y1;
        y1 = y;
    }

    return DiophantineSolution {
        solution_type: DiophantineSolutionType::UniqueSolution,
        x: x2 * c / a_copy,
        y: y2 * c / a_copy,
    };
}
