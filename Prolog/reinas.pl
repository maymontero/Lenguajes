boardRows([R1, R2, R3, R4, R5, R6, R7, R8], [N1, N2, N3, N4, N5, N6, N7, N8]) :-
    buildRow(N1, R1),
    buildRow(N2, R2),
    buildRow(N3, R3),
    buildRow(N4, R4),
    buildRow(N5, R5),
    buildRow(N6, R6),
    buildRow(N7, R7),
    buildRow(N8, R8).

buildRow(1, [queen, empty, empty, empty, empty, empty, empty, empty]).
buildRow(2, [empty, queen, empty, empty, empty, empty, empty, empty]).
buildRow(3, [empty, empty, queen, empty, empty, empty, empty, empty]).
buildRow(4, [empty, empty, empty, queen, empty, empty, empty, empty]).
buildRow(5, [empty, empty, empty, empty, queen, empty, empty, empty]).
buildRow(6, [empty, empty, empty, empty, empty, queen, empty, empty]).
buildRow(7, [empty, empty, empty, empty, empty, empty, queen, empty]).
buildRow(8, [empty, empty, empty, empty, empty, empty, empty, queen]).

eightQueens(B) :-
    permutation(B, [1, 2, 3, 4, 5, 6, 7, 8]).
    checkDiagonals(B).

checkDiagonals([]).
checkDiagonals([B|BS]) :-
    checkDiagonal(B, BS, 1),
    checkDiagonals(BS).

%checkDiagonal(B, BS, I) :-
%   zip(B, BS, R),



checkDiagonal(_, [], _).
checkDiagonal(N, [B|BS], I) :-
    \+(B is (N+I)),
    \+(B is (N-I)),
    checkDiagonal(N, BS, I+1).

zip([], [], []).
zip([_], [], []).
zip([], [_], []).
zip([X|Xs], [Y|Ys], [pair(X,Y)|XYs]) :-
   zip(Xs, Ys, XYs).
%[[queen, empty, empty, empty, empty, empty, empty, empty], [empty, queen, empty, empty, empty, empty, empty, empty], [empty, empty, queen, empty, empty, empty, empty, empty], [empty, empty, empty, queen, empty, empty, empty, empty], [empty, empty, empty, empty, queen, empty, empty, empty], [empty, empty, empty, empty, empty, queen, empty, empty], [empty, empty, empty, empty, empty, empty, queen, empty], [empty, empty, empty, empty, empty, empty, empty, queen]]