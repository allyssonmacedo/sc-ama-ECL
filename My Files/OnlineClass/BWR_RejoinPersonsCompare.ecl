IMPORT $;

RJPersons := DATASET('~ONLINE::allysson::OUT::Persons_Rejoined',
  $.File_Persons.Layout, THOR);
  
// Sort the appended records, and then dedup  
AppendRecs := $.File_Persons.File + RJPersons;
SortRecs := SORT(AppendRecs, RECORD);
DedupPersons := DEDUP(SortRecs, RECORD);

// Count of rejoined records created
OUTPUT(COUNT(RJPersons), NAMED('Input_Recs_Persons'));

// This result should be zero, which didnt happend
OUTPUT(COUNT(DedupPersons)-COUNT(RJPersons), NAMED('Dup_Persons'));

