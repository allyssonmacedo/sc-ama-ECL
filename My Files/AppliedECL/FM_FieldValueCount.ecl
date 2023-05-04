Export FM_FieldValueCount(infile, infield, maxrecs='ALL') := FUNCTIONMACRO
  r_macro := RECORD
    infile.infield;
    INTEGER cnt := COUNT(GROUP);
  END;

  RETURN OUTPUT(CHOOSEN(SORT(TABLE(infile, r_macro, infield), -cnt), maxrecs), NAMED('ValueCount_'+#TEXT(infield)));
ENDMACRO;

/* To implement, open a Builder Window:
    IMPORT <your folder> AS X;
    X.FM_FieldValueCount(X.Persons, Gender); 
*/