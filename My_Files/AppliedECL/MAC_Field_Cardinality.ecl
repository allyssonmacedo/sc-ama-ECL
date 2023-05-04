EXPORT MAC_Field_Cardinality(infile, infield) := MACRO
  #UNIQUENAME(t)
  %t%    := TABLE(infile, {infile.infield});
  #UNIQUENAME(dt)
  %dt%   := DISTRIBUTE(%t%, HASH32(infield));
  #UNIQUENAME(sdt)
  %sdt% := SORT(%dt%, infield, LOCAL);
  #UNIQUENAME(dsdt)
  %dsdt% := DEDUP(%sdt%, infield, LOCAL);

  OUTPUT(COUNT(%dsdt%), NAMED('Cardinality_'+ #TEXT(infield)));

ENDMACRO;
