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

factorial(N, F) :-
    N > 0,
    N1 is N-1,
    factorial(N1,F1),
    F is N * F1.

factorial(0, 1).

zip([], [], []).
zip([_], [], []).
zip([], [_], []).
zip([X|Xs], [Y|Ys], [pair(X,Y)|XYs]) :-
   zip(Xs, Ys, XYs).

treeHeight(nil, 0).
treeHeight(tree(V, L, R), H) :-
    treeHeight(L, LH),
    treeHeight(R, RH),
    H is (max(LH, RH) + 1).

begin(tictactoe(
    empty, empty, empty,
    empty, empty, empty,
    empty, empty, empty)).

winner(tictactoe(
    P, P, P,
    _, _, _,
    _, _, _), P) :-
    P \= empty.
winner(tictactoe(
    _, _, _,
    P, P, P,
    _, _, _), P) :-
    P \= empty.
winner(tictactoe(
    _, _, _,
    _, _, _,
    P, P, P), P) :-
    P \= empty.
winner(tictactoe(
    P, _, _,
    P, _, _,
    P, _, _), P) :-
    P \= empty.
winner(tictactoe(
    _, P, _,
    _, P, _,
    _, P, _), P) :-
    P \= empty.
winner(tictactoe(
    _, _, P,
    _, _, P,
    _, _, P), P) :-
    P \= empty.
winner(tictactoe(
    P, _, _,
    _, P, _,
    _, _, P), P) :-
    P \= empty.
winner(tictactoe(
    _, _, P,
    _, P, _,
    P, _, _), P) :-
    P \= empty.

loser(T, playerX) :-
    winner(T, playerO).
loser(T, playerO) :-
    winner(T, playerX).

tictactoe2List(tictactoe(S0, S1, S2, S3, S4, S5, S6, S7, S8), 
    [S0, S1, S2, S3, S4, S5, S6, S7, S8]).

emptyCount(T, N) :-
    tictactoe2List(T, TL),
    auxEmptyCount(TL, N).

auxEmptyCount([], 0).
auxEmptyCount([empty|SS], N) :-
    auxEmptyCount(SS, M),
    N is M+1.
auxEmptyCount([S|SS], N) :-
    S \= empty,
    auxEmptyCount(SS, N).

activePlayer(T, P) :-
    emptyCount(T, N),
    A is mod(N, 2),
    decidePlayer(A, P).

decidePlayer(1, playerX).
decidePlayer(0, playerO).

emptySquare(T, N) :-
    tictactoe2List(T, TL),
    nth0(N, TL, empty).

validAction(T, mark(P, I)) :-
    activePlayer(T, P),
    emptySquare(T, I).

actions(T, AS) :-
    activePlayer(T, P),
    include(validAction(T), [
        mark(P, 0), mark(P, 1), mark(P, 2),
        mark(P, 3), mark(P, 4), mark(P, 5),
        mark(P, 6), mark(P, 7), mark(P, 8)
    ], AS).