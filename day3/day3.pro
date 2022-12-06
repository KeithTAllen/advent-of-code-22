% Solves day 3 of 2022 Advent of Code
%   Program take a lists of Strings breaks them in half
%       then finds the shared character
%   The second part groups Strings in groups of 3 and
%       finds the only shared character between the 3
%   In both cases a value is assigned to each character
%       and the summed value is written

itemPriority(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]), %read in file
    split_string(Input_string,'\n', " ", List_of_sacks), %make string usable
    sackToHalves(List_of_sacks, Split_sacks), % split each entry into a list of two equal sized strings
    commonItemBig(Split_sacks, Reduced_sacks), % replace with 1 shared character
    flatten(Reduced_sacks, Flattened_sacks), % flatten cause its easier than debugging sometimes (don't worry I was able to find it eventually
    toValue(Flattened_sacks, Value_sacks), % swap chars to values
    sum_list(Value_sacks, Summed_sacks), % sum list
    write(Summed_sacks). % output result

groupPriority(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]), % read in file
    split_string(Input_string,'\n', " ", List_of_sacks), % make string usable
    splitInThree(List_of_sacks, Sacks_of_three), % split list into lists of 3
    commonItemGroupBig(Sacks_of_three, Reduced_sacks), % reduce to list of char badges
    toValue(Reduced_sacks, Value_sacks), % replace badges with values
    sum_list(Value_sacks, Summed_sacks), % sum list
    write(Summed_sacks). % output result

% ----------
% splits each list entry into a list of two equal sizes
sackToHalves([], []).
sackToHalves([X|Xs], [Y|Ys]) :-
    string_length(X, Z),
    XLength is (Z / 2),
    sub_string(X, 0, XLength, XLength, FirstHalf),
    sub_string(X, XLength, XLength, 0, SecondHalf),
    %write(FirstHalf), write("\n"), write(SecondHalf), write("\n"),
    Y = [FirstHalf, SecondHalf],
    sackToHalves(Xs, Ys).

% ----------
%turn each seperated sack into only their shared character
commonItemBig([],[]).
commonItemBig([[X1,X2]|Xs], [Y,Ys]) :- % the comma in the Y list should be a "|" this forces me to flatten it later
    string_chars(X1, X1Chars), string_chars(X2, X2Chars),
    XasChars = [X1Chars, X2Chars],
    commonItemInSack(XasChars,Y),
    commonItemBig(Xs, Ys).

commonItemInSack( [ [] | _ ], _).
commonItemInSack([ [FirstH | FirstT] , SecondHalf ] , Y):-
    %write("in the sack "),
     (member(FirstH, SecondHalf) -> Y = FirstH;
        %write("fail "), write(FirstT),
        commonItemInSack( [FirstT , SecondHalf], Y)
        ).

% ----------
% Turns each char into its value
toValue([],[]).
toValue([X|Xs], [Y|Ys]) :-
    char_code(X,XAscii),
    asciiToValue(XAscii, Y),
    toValue(Xs, Ys).
%all uppercase reassign
asciiToValue(XAscii, Y) :-
    XAscii < 97,
    Y is XAscii - 38.
%all lowercase reassign
asciiToValue(XAscii, Y) :-
    Y is XAscii - 96.

% ----------
% Splits list of all sacks into lists of 3
splitInThree([],[]).
splitInThree([ First, Second, Third | Xs],[Y|Ys]) :-
    Y = [First, Second, Third],
    splitInThree(Xs, Ys).

% ----------
%turn each seperated group into only their shared character
commonItemGroupBig([],[]).
commonItemGroupBig([[X1,X2,X3]|Xs], [Y|Ys]) :-
    write("entered GrouBig\n"),
    string_chars(X1, X1Chars), string_chars(X2, X2Chars), string_chars(X3, X3Chars),
    XasChars = [X1Chars, X2Chars, X3Chars],
    commonItemInGroup(XasChars,Y),
    commonItemGroupBig(Xs, Ys).

commonItemInGroup( [ [] | _ ], _).
commonItemInGroup([ [FirstH | FirstT] , SecondSack, ThirdSack ] , Y):-
    ((member(FirstH, SecondSack),
     member(FirstH, ThirdSack)) -> Y = FirstH;
    commonItemInGroup( [FirstT , SecondSack, ThirdSack], Y)).
