package body Iterative_Algebra is

    function Factorial (N : Natural64) return Natural64 is
        Result : Natural64;
    begin
        Result := 1;
        for I in 1..N loop
            Result := Result * I;
        end loop;
        return Result;
    end Factorial;

    function Gcd (A, B : Natural64) return Natural64 is
        N, M, TEMP : Natural64;
    begin
        N := (if A > B then A else B);
        M := (if A > B then B else A);

        while N /= 0 loop
            TEMP := N;
            N := M mod N;
            M := TEMP;
        end loop;

        return M;
    end Gcd;

    function Solve_Diophantine (A, B, C : Integer64) return Diophantine_Solution is
        Positive_A, Positive_B, Positive_C, GCD_A_B : Natural64;
        A_Copy, B_Copy, X1, X2, Y1, Y2 : Integer64;
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

        A_Copy := A;
        B_Copy := B;
        X1 := 0;
        Y1 := 1;
        X2 := 1;
        Y2 := 0;

        while B_Copy /= 0 loop
            declare
                Q, R, X_Tmp, Y_Tmp : Integer64;
            begin
                Q := A_Copy / B_Copy;
                R := A_Copy mod B_Copy;
                X_Tmp := X2 - Q * X1;
                Y_Tmp := Y2 - Q * Y1;
                A_Copy := B_Copy;
                B_Copy := R;
                X2 := X1;
                Y2 := Y1;
                X1 := X_Tmp;
                Y1 := Y_Tmp;
            end;
        end loop;

        return (Unique_Solution, X2 * C / Integer64(GCD_A_B), Y2 * C / Integer64(GCD_A_B));
    end Solve_Diophantine;
end Iterative_Algebra;
