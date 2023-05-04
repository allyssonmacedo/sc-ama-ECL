EXPORT FM_Field_Population(infile, infield, compareval) := FUNCTIONMACRO 
c1_macro := COUNT(infile(infield=compareval));
c2_macro := COUNT(infile);

RETURN OUTPUT(DATASET([
    {'Total Records', c2_macro},
    {'Recs' + #TEXT(infield) + ' = ' + #TEXT(compareval), c1_macro},
    {'Population Pct', (INTEGER) (((c2_macro-c1_macro)/c2_macro)*100.0)}],
    {STRING35 valuetype, INTEGER val}), NAMED('Population_'+#TEXT(infield)), EXTEND);

ENDMACRO;