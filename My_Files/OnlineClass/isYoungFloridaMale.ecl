// EXPORT isYoungFloridaMale := 'todo';

IMPORT $;

isFloridian := $.Persons.State = 'FL';
isMale      := $.Persons.Gender = 'M';
isBorn80    := $.Persons.BirthDate[..4] > '1979' AND
               $.Persons.BirthDate <> '';

EXPORT isYoungFloridaMale := isFloridian AND
                             isMale AND 
                             isBorn80;
