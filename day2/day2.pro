% Solves day 2 of 2022 Advent of Code
%   The process is the same convert the file into a list of 2 letter inputs
%   Use a map function to convert letters to a list of scores of rounds determined by the rules
%   Sum the list of rounds
%   Print the sum
%
%   The there are two sets of helper functions to account for the two sets of rules

round1(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]),
    split_string(Input_string,'\n', " ", Input_list),
    fixInput(Input_list, Output_list),
    sum_list(Output_list, Sum),
    write(Sum).

round2(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]),
    split_string(Input_string,'\n', " ", Input_list),
    fixInput2(Input_list, Output_list),
    sum_list(Output_list, Sum),
    write(Sum).


% Helper functions for round 1
fixInput([], []).
fixInput([X|Xs], [Y|Ys]) :-
    assignScore(X,Y),
    fixInput(Xs, Ys).

assignScore(X, Y) :- X = "A X", Y is 4.
assignScore(X, Y) :- X = "A Y", Y is 8.
assignScore(X, Y) :- X = "A Z", Y is 3.
assignScore(X, Y) :- X = "B X", Y is 1.
assignScore(X, Y) :- X = "B Y", Y is 5.
assignScore(X, Y) :- X = "B Z", Y is 9.
assignScore(X, Y) :- X = "C X", Y is 7.
assignScore(X, Y) :- X = "C Y", Y is 2.
assignScore(X, Y) :- X = "C Z", Y is 6.

% helpers for round 2
fixInput2([], []).
fixInput2([X|Xs], [Y|Ys]) :-
    assignScore2(X,Y),
    fixInput2(Xs, Ys).

assignScore2(X, Y) :- X = "A X", Y is 3.
assignScore2(X, Y) :- X = "A Y", Y is 4.
assignScore2(X, Y) :- X = "A Z", Y is 8.
assignScore2(X, Y) :- X = "B X", Y is 1.
assignScore2(X, Y) :- X = "B Y", Y is 5.
assignScore2(X, Y) :- X = "B Z", Y is 9.
assignScore2(X, Y) :- X = "C X", Y is 2.
assignScore2(X, Y) :- X = "C Y", Y is 6.
assignScore2(X, Y) :- X = "C Z", Y is 7.

