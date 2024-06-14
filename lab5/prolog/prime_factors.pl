factorize(1, _, []).
factorize(N, Divisor, [Divisor|Factors]) :-
    N mod Divisor =:= 0,
    NewN is N // Divisor,
    factorize(NewN, Divisor, Factors).
factorize(N, Divisor, Factors) :-
    N mod Divisor =\= 0,
    NextDivisor is Divisor + 1,
    factorize(N, NextDivisor, Factors).

primeFactors(N, Factors) :-
    N =< 1,
    Factors = [].
primeFactors(N, Factors) :-
    N > 1,
    factorize(N, 2, Factors).