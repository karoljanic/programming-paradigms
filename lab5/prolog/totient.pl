gcd(A, 0, A).
gcd(A, B, GCD) :-
    B > 0,
    C is A mod B,
    gcd(B, C, GCD).

coprime(X, Y) :-
    gcd(X, Y, GCD),
    GCD =:= 1.

totientUtil(_, 1, T, T) :- !.
totientUtil(N, M, Acc, T) :-
    M > 1,
    coprime(N, M),
    NewAcc is Acc + 1,
    NewM is M - 1,
    totientUtil(N, NewM, NewAcc, T).
totientUtil(N, M, Acc, T) :-
    M > 1,
    \+ coprime(N, M),
    NewM is M - 1,
    totientUtil(N, NewM, Acc, T).

totient(1, 1).
totient(N, T) :-
    N > 1,
    totientUtil(N, N, 1, T).