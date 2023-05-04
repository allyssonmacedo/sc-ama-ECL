// EXPORT BWR_State_Population := 'todo';

IMPORT $, Visualizer;

Persons := $.File_Persons.File;

Rec := RECORD
Persons.State;
UNSIGNED4 StateCnt := COUNT(GROUP);
END;

OUTPUT(TABLE(Persons, Rec, State),NAMED('usStates'));
Visualizer.Choropleth.USStates('usStates',,'usStates');