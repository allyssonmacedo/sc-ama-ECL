
EXPORT FM_Field_Cardinality(infile, infield) := FUNCTIONMACRO
  t    := TABLE(infile, {infile.infield});
  dt   := DISTRIBUTE(t, HASH32(infield));
  sdt  := SORT(dt, infield, LOCAL);
  dsdt := DEDUP(sdt, infield, LOCAL);

  RETURN OUTPUT(COUNT(dsdt), NAMED('Cardinality_'+ #TEXT(infield)));

ENDMACRO;


