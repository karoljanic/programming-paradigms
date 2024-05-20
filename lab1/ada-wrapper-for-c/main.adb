with Interfaces.C; use Interfaces.C;
with Ada.Text_IO;  use Ada.Text_IO;
with Interfaces.C;

procedure Main is
    type Natural64 is mod 2**64;
    type Integer64 is range -(2**63) .. (2**63-1);

    type Diophantine_Solution_Result is (No_Solution, Unique_Solution, Infinite_Solutions)
    with
        Convention => C;

    type Diophantine_Solution is record
        result : Diophantine_Solution_Result;
        x : Integer64;
        y : Integer64;
    end record;
        
    function Factorial(n: Natural64) return Natural64
    with
        Import        => True,
        Convention    => C,
        External_Name => "factorial";

    function Gcd(a, b: Natural64) return Natural64 
    with
        Import      => True,
        Convention  => C,
        External_Name => "gcd";

    function Solve_Diophantine(a, b, c: Integer64) return Diophantine_Solution
    with
        Import          => True,
        Convention      => C,
        External_Name   => "solve_diophantine";

   FactorialResult: Natural64;
   GcdResult: Natural64;
   DiophantineResult: Diophantine_Solution;
begin
   FactorialResult := Factorial(7);
   Put_Line("Factorial(7) =" & FactorialResult'Image); 

   GcdResult := Gcd(18, 12);
   Put_Line("Gcd(18,12) =" & GcdResult'Image);

   DiophantineResult := Solve_Diophantine(12, 15, -9);
   Put_Line("Solve_Diophantine(12, 15, -9) = (" & DiophantineResult.Result'Image & ", " & DiophantineResult.X'Image & ", " & DiophantineResult.Y'Image & ")");

end Main;
