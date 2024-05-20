package Iterative_Algebra is
   type Natural64 is mod 2**64;
   type Integer64 is range -(2**63) .. (2**63-1);

   type Diophantine_Solution_Result is (No_Solution, Unique_Solution, Infinite_Solutions)
   with
      Convention => C;
   
   type Diophantine_Solution is record
      Result : Diophantine_Solution_Result;
      X : Integer64;
      Y : Integer64;
   end record
   with 
      Convention => C;

    function Factorial (N : Natural64) return Natural64
    with
      Export        => True,
      Convention    => C,
      External_Name => "factorial";

    function Gcd (A, B : Natural64) return Natural64
    with
      Export        => True,
      Convention    => C,
      External_Name => "gcd";

    function Solve_Diophantine (A, B, C : Integer64) return Diophantine_Solution
    with
      Export        => True,
      Convention    => C,
      External_Name => "solve_diophantine";

end Iterative_Algebra;
