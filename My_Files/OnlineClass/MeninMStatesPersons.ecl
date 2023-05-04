IMPORT $;

// EXPORT 
MenInMStatesPersons := $.Persons(State IN $.SetMStates,
                                        Gender = 'M');
                                        
OUTPUT(MenInMStatesPersons);

COUNT(MenInMStatesPersons);