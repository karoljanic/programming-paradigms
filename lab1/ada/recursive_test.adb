with Ada.Text_IO; use Ada.Text_IO;

with Recursive_Algebra; use Recursive_Algebra;

procedure Main is 

    procedure Test_Factorial(N : Natural64; Expected : Natural64) is
        Factorial_Result : Natural64;
    begin
        Factorial_Result := Factorial(N);
        if Factorial_Result = Expected then
            Put_Line("PASSED: Factorial(" & N'Image & " ) =" & Factorial_Result'Image);
        else
            Put_Line("FAILED: Factorial(" & N'Image & " ) =" & Factorial_Result'Image & ", Expected =" & Expected'Image);
        end if;
    end Test_Factorial;

    procedure Test_Gcd(A, B : Natural64; Expected : Natural64) is
        Gcd_Result : Natural64;
    begin
        Gcd_Result := Gcd(A, B);
        if Gcd_Result = Expected then
            Put_Line("PASSED: Gcd(" & A'Image & "," & B'Image & " ) =" & Gcd_Result'Image);
        else
            Put_Line("FAILED: Gcd(" & A'Image & "," & B'Image & " ) =" & Gcd_Result'Image & ", Expected =" & Expected'Image);
        end if;
    end Test_Gcd;

    procedure Test_Diophantine(A, B, C : Integer64; Expected : Diophantine_Solution) is
        Diophantine_Result : Diophantine_Solution;
    begin
        Diophantine_Result := Solve_Diophantine(A, B, C);
        if Diophantine_Result = Expected then
            Put_Line("PASSED: Solve_Diophantine(" & A'Image & "," & B'Image & "," & C'Image & ") = (" & Diophantine_Result.X'Image & "," & Diophantine_Result.Y'Image & ", " & Diophantine_Result.Result'Image & " )");
        else 
            Put_Line("FAILED: Solve_Diophantine(" & A'Image & "," & B'Image & "," & C'Image & ") = (" & Diophantine_Result.X'Image & "," & Diophantine_Result.Y'Image & ", " & Diophantine_Result.Result'Image & " )" & ", Expected = (" & Expected.X'Image & "," & Expected.Y'Image & ", " & Expected.Result'Image & " )");
        end if;
    end Test_Diophantine;

begin
    -- Test factorial
    Test_Factorial(0, 1);
    Test_Factorial(1, 1);
    Test_Factorial(2, 2);
    Test_Factorial(7, 5040);
    Test_Factorial(12, 479001600);

    -- Test gcd
    Test_Gcd(0, 0, 0);
    Test_Gcd(0, 1, 1);
    Test_Gcd(1, 0, 1);
    Test_Gcd(1, 1, 1);
    Test_Gcd(4, 6, 2);
    Test_Gcd(12, 18, 6);
    Test_Gcd(18, 12, 6);
    Test_Gcd(17, 120, 1);

    -- Test diophantine_solution
    Test_Diophantine(0, 0, 0, (INFINITE_SOLUTIONS, 0, 0));
    Test_Diophantine(0, 0, 1, (NO_SOLUTION, 0, 0));
    Test_Diophantine(12, 15, 3, (UNIQUE_SOLUTION, -1, 1));
    Test_Diophantine(12, 15, -3, (UNIQUE_SOLUTION, 1, -1));
    Test_Diophantine(12, 15, -9, (UNIQUE_SOLUTION, 3, -3));
    Test_Diophantine(12, 15, 4, (NO_SOLUTION, 0, 0));
end Main;
