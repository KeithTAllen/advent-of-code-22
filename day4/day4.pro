whoOverlaps(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]), % read in file
    split_string(Input_string,",\n", "", List_of_assignments), % make string usable
    sort_to_double(List_of_assignments, List_of_assignments_pairs), % list of lists of pairs
    %write(List_of_assignments_pairs), write("\n"),
    find_overlaps(List_of_assignments_pairs, List_of_Overlaps), % find all overlaps and set them to 1
    %write(List_of_Overlaps), write("\n"),
    sum_list(List_of_Overlaps, Summed_sacks), % sum list
    write(Summed_sacks). % output result

main(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]), % read in file
    split_string(Input_string,",\n", "", List_of_assignments), % make string usable
    sort_to_double(List_of_assignments, List_of_assignments_pairs), % list of lists of pairs
    write(List_of_assignments_pairs), write("\n"),
    find_overlap_length(List_of_assignments_pairs, List_of_Overlaps), % find all overlaps and set them to 1
    write(List_of_Overlaps), write("\n"),
    sum_list(List_of_Overlaps, Summed_sacks), % sum list
    write(Summed_sacks). % output result




%finds all overlapping regions and sets them to 1
find_overlap_length([],[]).
find_overlap_length([ [RangeOne , RangeTwo ] | Xs], [Y|Ys]) :-
    split_string(RangeOne, "-", "", RangeOneList),
    split_string(RangeTwo, "-", "", RangeTwoList),

    %get range start and end
    RangeOneList = [ RangeOneStart, RangeOneEnd ],
    RangeTwoList = [ RangeTwoStart, RangeTwoEnd],

    %swap ranges to numbers to compare
    number_string(RangeOneStartNum, RangeOneStart), number_string(RangeOneEndNum, RangeOneEnd),
    number_string(RangeTwoStartNum, RangeTwoStart), number_string(RangeTwoEndNum, RangeTwoEnd),


    %write(RangeOneStart), write(" "), write(RangeOneEnd), write(" "), write(RangeTwoStart), write(" "), write(RangeTwoEnd), write(" | "),
    ( overlap(RangeOneStartNum, RangeTwoStartNum, RangeOneEndNum, RangeTwoEndNum, OverlapLength) ->
        Y = 1, find_overlap_length(Xs, Ys);
    %write("we failed"),
    Y = 0,
    find_overlap_length(Xs, Ys)
    ).

%returns true if they overlap at all
overlap(RangeOneStartNum, RangeTwoStartNum, RangeOneEndNum, RangeTwoEndNum, OverlapLength) :-
    RangeOneStartNum >= RangeTwoStartNum,
    RangeTwoEndNum >= RangeOneEndNum,
    OverlapLength is RangeOneEndNum - RangeOneStartNum + 1,
    write("passed 3 | ").
overlap(RangeOneStartNum, RangeTwoStartNum, RangeOneEndNum, RangeTwoEndNum, OverlapLength) :-
    RangeOneStartNum =< RangeTwoStartNum,
    RangeTwoEndNum =< RangeOneEndNum,
    OverlapLength is RangeTwoEndNum - RangeTwoStartNum,
    write("passed 4 | ").
overlap( RangeOneStartNum, RangeTwoStartNum, RangeOneEndNum, RangeTwoEndNum, OverlapLength ) :-
    RangeOneEndNum >= RangeTwoStartNum,
    RangeOneStartNum =< RangeTwoEndNum,
    OverlapLength is RangeOneEndNum - RangeTwoStartNum + 1,
    write("passed 1 | ").
overlap(RangeOneStartNum, RangeTwoStartNum, RangeOneEndNum, RangeTwoEndNum, OverlapLength) :-
    RangeTwoEndNum >= RangeOneStartNum,
    RangeOneEndNum >= RangeTwoStartNum,
    OverlapLength is RangeTwoEndNum - RangeOneStartNum + 1,
    write("passed 2 | ").


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
%
%
%
%
%

%finds all overlapping regions and sets them to 1
find_overlaps([],[]).
find_overlaps([ [RangeOne , RangeTwo ] | Xs], [Y|Ys]) :-
    split_string(RangeOne, "-", "", RangeOneList),
    split_string(RangeTwo, "-", "", RangeTwoList),
    RangeOneList = [ RangeOneStart, RangeOneEnd ],
    RangeTwoList = [ RangeTwoStart, RangeTwoEnd],

    %write(RangeOneStart), write(" "), write(RangeOneEnd), write(" "), write(RangeTwoStart), write(" "), write(RangeTwoEnd), write(" | "),
    (overlaps(RangeOneStart, RangeTwoStart, RangeOneEnd, RangeTwoEnd) ->
        Y = 1, find_overlaps(Xs, Ys);
    %write("we failed"),
    Y = 0,
    find_overlaps(Xs, Ys)
    ).

%range 1 overlaps range 2
overlaps(RangeOneStart, RangeTwoStart, RangeOneEnd, RangeTwoEnd) :-
    number_string(RangeOneStartNum, RangeOneStart), number_string(RangeOneEndNum, RangeOneEnd),
    number_string(RangeTwoStartNum, RangeTwoStart), number_string(RangeTwoEndNum, RangeTwoEnd),
    RangeOneStartNum =< RangeTwoStartNum,
    %write("passed1.1 "),
    RangeOneEndNum >= RangeTwoEndNum.
    %write("passed1.2 ").
    %write("passed 1 ").

%range 2 overlaps range 1
overlaps(RangeOneStart, RangeTwoStart, RangeOneEnd, RangeTwoEnd) :-
    number_string(RangeOneStartNum, RangeOneStart), number_string(RangeOneEndNum, RangeOneEnd),
    number_string(RangeTwoStartNum, RangeTwoStart), number_string(RangeTwoEndNum, RangeTwoEnd),
    RangeTwoStartNum =< RangeOneStartNum ,
    RangeTwoEndNum >= RangeOneEndNum.
    %write("passed 2 ").

% sorts list into lists of pairs
sort_to_double([],[]).
sort_to_double([First, Second |Xs], [Y|Ys]) :-
    Y = [First, Second],
    sort_to_double( Xs, Ys ).