d := DATASET('~advanced2::imdb_movies', {STRING line}, CSV(SEPARATOR(''), QUOTE('')));

PATTERN arb := ANY+;
PATTERN alpha := PATTERN('[a-zA-Z]')+;
PATTERN Numbers := PATTERN('[-0-9?,]')+;
PATTERN fs := PATTERN('\t') +; //field separator
PATTERN Year := '(' Numbers OPT('/' arb) ')';
PATTERN Vidtype := ' (' alpha ')';
PATTERN Title := arb Year OPT(Vidtype);
PATTERN movieyr := Numbers;
PATTERN comment := '(' arb ')';
RULE moviedata := Title fs movieyr OPT(fs comment);

Outrec := RECORD 
    STRING MovieTitle{MAXLENGTH(250)} := MATCHTEXT(Title/arb);
    STRING Titleyear{MAXLENGTH(20)} := MATCHTEXT(Title/Year);
    STRING MovieType{MAXLENGTH(10)} := MATCHTEXT(Title/Vidtype);
    STRING Releaseyear{MAXLENGTH(40)} := MATCHTEXT(movieyr);
    STRING AddedComments{MAXLENGTH(50)} := MATCHTEXT(comment);    
END;

x := PARSE(d, line, moviedata, Outrec, WHOLE, FIRST);
x;