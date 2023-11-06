readFile:-
    open('teste.txt', read, File),
    read_lines(File, Lines),
    close(File),
    write(Lines), nl.

read_lines(File,[]):-
    at_end_of_stream(File).

read_lines(File,[X|L]):-
    \+ at_end_of_stream(File),
    read(File,X),
    read_lines(File,L).
