de(A, 0, 1, 0, A).
de(A, B, X, Y, Z) :-
    B > 0,
    Tmp is A mod B,
    de(B, Tmp, X1, Y1, Z),
    X is Y1,
    Y is X1 - Y1 * (A // B).
