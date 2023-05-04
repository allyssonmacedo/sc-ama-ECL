// EXPORT BWR_BasicQueries := 'todo';

IMPORT $;

$.Persons;

COUNT($.Persons);

OUTPUT($.Persons, {RecID, LastName, FirstName} );

OUTPUT($.Persons, {RecID, StreetAdress, City, State, ZipCode}, Named('Adress_Info') );