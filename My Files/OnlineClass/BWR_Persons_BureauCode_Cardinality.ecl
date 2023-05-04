//EXPORT BWR_Persons_BureauCode_Cardinality := 'todo';

IMPORT $;

table1 := TABLE($.File_Persons.File,
               {$.File_Persons.File.BureauCode});

Distribute1 := DISTRIBUTE(table1, HASH32(BureauCode));

SortedValues := SORT(Distribute1,BureauCode, LOCAL);

DedupValues := DEDUP(SortedValues, BureauCode, LOCAL);

COUNT(DedupValues);
table1;
Distribute1;
SortedValues;
DedupValues;
