main(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]), %read in file
    %write(Input_string),
    string_chars(Input_string, Char_list),
    %write(Char_list),
    findStart(Char_list, Start_index, 0),
    write(Start_index).


findStart([],_,_).
findStart([ A, B, C, D, E, F, G, H, I, J, K, L, M, N | Xs], StartIndex, Count) :-
    (not(A == B), not(A == C), not(A == D), not(A == E), not(A == F), not(A == G),
     not(A == H), not(A == I), not(A == J), not(A == K), not(A == L), not(A == M),
     not(A == N),

     not(B == C), not(B == D), not(B == E), not(B == F), not(B == G),
     not(B == H), not(B == I), not(B == J), not(B == K), not(B == L), not(B == M),
     not(B == N),

     not(C == D),
     not(C == E),
     not(C == F),
     not(C == G),
     not(C == H),
     not(C == I),
     not(C == J),
     not(C == K),
     not(C == L),
     not(C == M),
     not(C == N),

     not(D == E),
     not(D == F),
     not(D == G),
     not(D == H),
     not(D == I),
     not(D == J),
     not(D == K),
     not(D == L),
     not(D == M),
     not(D == N),

     not(E == F),
     not(E == G),
     not(E == H),
     not(E == I),
     not(E == J),
     not(E == K),
     not(E == L),
     not(E == M),
     not(E == N),

     not(F == G),
     not(F == H),
     not(F == I),
     not(F == J),
     not(F == K),
     not(F == L),
     not(F == M),
     not(F == N),

     not(G == H),
     not(G == I),
     not(G == J),
     not(G == K),
     not(G == L),
     not(G == M),
     not(G == N),

     not(H == I),
     not(H == J),
     not(H == K),
     not(H == L),
     not(H == M),
     not(H == N),

     not(I == J),
     not(I == K),
     not(I == L),
     not(I == M),
     not(I == N),

     not(J == K),
     not(J == L),
     not(J == M),
     not(J == N),

     not(K == L),
     not(K == M),
     not(K == N),

     not(L == M),
     not(L == N),

     not(M == N)

     ->
     StartIndex is 14 + Count;
     %write("fail "),
     Xs = [FirstTail | TrueTail],
     NewCount is Count + 1,
     findStart([B, C, D, E, F, G, H, I ,J ,K ,L , M ,N, FirstTail | TrueTail], StartIndex, NewCount)
    ).