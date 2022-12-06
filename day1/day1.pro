% Code used to solve 2022 Advent of Code Day 1
%   The topElf prints out the solution to the first problem
%   top3Elves prints out the solution to the second problem
%
%   topElf uses a more complicated findBest method to parse through the list of elves
%       while top3Elves relies more on built in functions to answer.

top3Elves(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]),
    split_string(Input_string,'\n\n', "", Input_list),
    %write(Input_list), write('\n'),
    %write(Input_string), write('\n'),
    split(Input_list, List_of_lists),
    %write(List_of_lists), write('\n'),
    %findBest(List_of_lists, 0).
    listOfSums( List_of_lists, List_of_sums ),
    write(List_of_sums),
    %Now we find the best and start to delete
    max_member(First, List_of_sums),
    delete(List_of_sums, First, List_of_sums2),

    max_member(Second, List_of_sums2),
    delete(List_of_sums2, Second, List_of_sums3),

    max_member(Third, List_of_sums3),

    %write(First), write(' | '), write(Second), write(' | '), write(Third), write(' | \n'),
    TopThree is First + Second + Third,
    write(TopThree).

topElf(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]),
    split_string(Input_string,'\n\n', "", Input_list),
    %write(Input_list), write('\n'),
    %write(Input_string), write('\n'),
    split(Input_list, List_of_lists),
    %write(List_of_lists), write('\n'),
    findBest(List_of_lists, 0).

%base case
findBest( [], BestTotal) :-
    write(BestTotal).
%iterates through list of "eleves" to eventually print out the best one
findBest([CurrentElf|OtherElves], BestTotal) :-
    %write(CurrentElf), write('\n'), write(OtherElves), write('\n'), write(BestTotal), write('\n'),
    sumList(CurrentElf, CurrentSum),
    %write(CurrentSum), write('\n'),
    ( CurrentSum > BestTotal ->
        %write('passed if'), write('\n'),
        %write('reassigned'),
        findBest(OtherElves, CurrentSum);
    findBest(OtherElves, BestTotal) ).

% finds the sum of a list (needed this since with the input files everything thinks its a string not an integer
sumList([], 0).
sumList([H|T], N) :-
    sumList(T, N1),
    number_string(HN, H),
    N is N1 + HN.

%Helper funtions to split the Input_list into a list of lists by finding the double breaks
takeUntil( []     , _ , []     , [] ) .
takeUntil( [X|Xs] , X , []     , Xs ) .
takeUntil( [X|Xs] , S , [X|Ps] , Rs ) :-
  X \= S ,
  takeUntil( Xs , S , Ps , Rs ).

split( []     , []     ) .
split( [X|Xs] , [Y|Ys] ) :-
    takeUntil( [X|Xs] , "", Y , R ) ,
    split(R, Ys ).

%funtion to reduce the list_of_lists to just a list of sums mapfxn
listOfSums([], []).
listOfSums([X|Xs], [Y|Ys]) :-
   sumList(X,Y),
   listOfSums(Xs, Ys).