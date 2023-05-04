IMPORT $;

SortPersons := SORT($.Persons, LastName, FirstName, RecID);


EXPORT 
DedupPersons := DEDUP(SortPersons,
                      LEFT.LastName = RIGHT.LastName AND
                      LEFT.FirstName = RIGHT.FirstName) 
                      : PERSIST('~CLASS::allysson::PERSIST::DedupPersons');


//COUNT(DedupPersons);