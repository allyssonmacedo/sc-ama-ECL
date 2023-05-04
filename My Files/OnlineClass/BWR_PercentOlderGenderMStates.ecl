
IMPORT $;

// We want a ration of men in 'M' states born before 1980
// to men in All states born before 1980 (express in percentage to two decimal places)

IsOlderPerson := $.Persons.BirthDate[1..4] < '1980' AND $.Persons.BirthDate <> '';

//OlderManinMStates := COUNT($.MeninMStatesPersons(IsOlderPerson)); // Olders man in M States
ManinMStatesPersons := $.Persons(State IN $.SetMStates, Gender = 'M');
OlderManinMStates := COUNT(ManinMStatesPersons(isOlderPerson));
OlderManinAllStates := COUNT($.Persons(Gender = 'M', IsOlderPerson)); // All Older Man
PercOlderMalesinMStates := (DECIMAL5_2) (OlderManinMStates / OlderManinAllStates * 100); // Ratio

//Females
FemaleinMStatesPersons := $.Persons(State IN $.SetMStates, Gender = 'F');
OlderFemaleinMStates := COUNT(FemaleinMStatesPersons(isOlderPerson));
OlderFemaleinAllStates := COUNT($.Persons(Gender = 'F', isOlderPerson));
PercOlderFemalesinMStates := (DECIMAL5_2) (OlderFemaleinMStates / OlderFemaleinAllStates * 100);

OUTPUT(PercOlderMalesinMStates, NAMED('Men_Percentage'));
OUTPUT(PercOlderFemalesinMStates, NAMED('Female_Percentage'));

// EXPORT BWR_PercentOlderGenderMStates := 'todo';