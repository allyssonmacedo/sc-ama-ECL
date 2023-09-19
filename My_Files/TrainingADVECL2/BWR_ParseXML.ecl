rec := RECORD 
    INTEGER2 seq;
    STRING line;
END;

/// erro no spray do arquivo era para ser thor
//ds := DATASET('~advanced2::EmbeddedXMLtimezones', rec, CSV(SEPARATOR('/>')));
ds := DATASET('~advanced2::EmbeddedXMLtimezones', rec, THOR);

outrec := RECORD
    STRING code{MAXLENGTH(160)};
    STRING description{MAXLENGTH(160)};
    STRING zone{MAXLENGTH(40)};
END;

outrec ParseIt(rec L) := TRANSFORM
    SELF.code := XMLTEXT('@code');
    SELF.description := XMLTEXT('@description');
    SELF.zone := XMLTEXT('@zone');
END;



x := PARSE(ds, line, ParseIt(LEFT), XML('area'));
OUTPUT(x);