split([], [], []).
split([X], [X], []).
split([X, Y| Rest], [X | L1], [Y | L2]) :-
    split(Rest, L1, L2).

merge([], L, L).
merge(L, [], L).
merge([X | L1], [Y | L2], [X | L]) :-
    X =< Y,
    merge(L1, [Y | L2], L).
merge([X | L1], [Y | L2], [Y | L]) :-
    X > Y,
    merge([X | L1], L2, L).

mergesort([], []).
mergesort([X], [X]).
mergesort(X, Y) :-
    split(X, L1, L2),
    mergesort(L1, SortedL1),
    mergesort(L2, SortedL2),
    merge(SortedL1, SortedL2, Y).
