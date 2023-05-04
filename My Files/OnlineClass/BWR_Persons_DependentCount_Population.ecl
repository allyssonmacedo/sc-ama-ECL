//EXPORT BWR_Persons_DependentCount_Population := 'todo';

IMPORT $;

Population := COUNT($.File_Persons.File);
ZeroDependents := COUNT($.File_Persons.File(DependentCount = 0));
Pct := (INTEGER) (((Population - ZeroDependents)/Population) * 100);

Dt := DATASET([{'Total Records', Population},
              {'Recs=0', ZeroDependents},
              {'Population Pct', Pct}],
              {STRING15 Valuetype, INTEGER val});

OUTPUT(Dt);
