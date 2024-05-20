package Recursive_Algebra is

    type Natural64 is mod 2**64;
    type Integer64 is range -(2**63) .. (2**63-1);

    type Diophantine_Solution_Result is (No_Solution, Unique_Solution, Infinite_Solutions);
    type Diophantine_Solution is record
        Result : Diophantine_Solution_Result;
        X : Integer64;
        Y : Integer64;
    end record;

    function Factorial (N : Natural64) return Natural64;

    function Gcd (A, B : Natural64) return Natural64;

    function Solve_Diophantine (A, B, C : Integer64) return Diophantine_Solution;
    
end Recursive_Algebra;
