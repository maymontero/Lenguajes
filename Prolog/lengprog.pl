language(ut1, haskell).
language(ut2, prolog).
language(ut3, clang).
language(ut4, ruby).
language(ut5, javascript).

inBetween(A, X, B) :-
    var(X),
    A =< B,
    X is ((A+B)/2).

inBetween(X, A, B) :-
    var(X),
    A =< B,
    X is A.

inBetween(A, B, X) :-
    var(X),
    A =< B,
    X is B.

inBetween(A, X, B) :-
    X =< B,
    X >= A.