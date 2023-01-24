main(Input_filename) :-
    read_file_to_string(Input_filename, Input_string,[]), %read in file
    split_string(Input_string,'\n', " ", List_of_instructions), %make string usable
    write(List_of_instructions).