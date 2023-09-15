import My_Files.OnlineClass As source;

IMPORT $, STD;

Persons := source.File_Persons.File;
profileResults := STD.DataPatterns.Profile(Persons);

bestrecord := STD.DataPatterns.BestRecordStructure(Persons);

OUTPUT(profileResults, ALL, NAMED('profileResults'));
OUTPUT(bestrecord, ALL, NAMED('BestRecord'));