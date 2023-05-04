EXPORT MAC_Field_ValueCount(infile, infield, maxrecs='ALL') := MACRO
    #UNIQUENAME(r_macro)
    %r_macro% := RECORD
    infile.infield;
    INTEGER cnt := COUNT(GROUP);
    END;

  OUTPUT(CHOOSEN(SORT(TABLE(infile, %r_macro%, infield), -cnt), maxrecs), NAMED('ValueCount_'+#TEXT(infield)));
ENDMACRO;