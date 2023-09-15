r := RECORD 
    STRING code{XPATH('@code')};
    STRING description{XPATH('@description')};
    STRING zone{XPATH('@zone')};
END;

d := DATASET('~advanced2::complextimezones.xml', r, XML('dataset/area'));

OUTPUT(d);