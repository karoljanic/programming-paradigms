hasFactor(N, Factor) :-
    N mod Factor =:= 0.
hasFactor(N, Factor) :-
    Factor * Factor < N,
    NextFactor is Factor + 2
    hasFactor(N, NextFactor).

isPrime(2).
isPrime(3).
isPrime(P) :-
    P > 3,
    P mod 2 =\= 0,
    \+ hasFactor(P, 3).

primes(N, Primes) :-
    findall(P, (between(2, N, P), isPrime(P)), Primes).