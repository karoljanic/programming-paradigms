package body Recursive_Algebra is

    function Factorial (N : Natural64) return Natural64 is
        Result: Natural64;
    begin
        Result := 1;

        if N = 0 then
            return 1;
        else
            return N * Factorial (N - 1);
        end if;
    end Factorial;

    function Gcd (A, B : Natural64) return Natural64 is
        N, M : Natural64;
    begin
        N := (if A > B then A else B);
        M := (if A > B then B else A);
        if M = 0 then
            return N;
        else
            return Gcd (M, N mod M);
        end if;
    end Gcd;

    function Solve_Diophantine (A, B, C : Integer64) return Diophantine_Solution is
        Positive_A, Positive_B, Positive_C, GCD_A_B : Natural64;
        X, Y : Integer64;
        Solution : Diophantine_Solution;
    begin
        Positive_A := (if A > 0 then Natural64(A) else Natural64(-A));
        Positive_B := (if B > 0 then Natural64(B) else Natural64(-B));
        Positive_C := (if C > 0 then Natural64(C) else Natural64(-C));
        GCD_A_B := Gcd (Positive_A, Positive_B);

        if GCD_A_B = 0 then
            if C = 0 then
                return (Infinite_Solutions, 0, 0);
            else
                return (No_Solution, 0, 0);
            end if;
        end if;

        if Positive_C mod GCD_A_B /= 0 then
            return (No_Solution, 0, 0);
        end if;

        if B = 0 then
            return (Unique_Solution, C / A, 0);
        end if;

        Solution := Solve_Diophantine (B, A mod B, C);
        X := Solution.X;
        Y := Solution.Y;
        Solution.X := Y;
        Solution.Y := X - (A / B) * Y;
        
        return Solution;
    end Solve_Diophantine;

end Recursive_Algebra;
