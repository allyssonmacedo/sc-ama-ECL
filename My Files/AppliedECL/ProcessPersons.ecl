IMPORT $;
IMPORT OnlineClass AS X;
IMPORT STD;

X.File_persons.Layout toUpperPlease(X.File_persons.Layout pInput) := TRANSFORM
    SELF.FirstName := Std.Str.ToUpperCase(pInput.FirstName);
    SELF.LastName := Std.Str.ToUpperCase(pInput.LastName);
    SELF.MiddleName := Std.Str.ToUpperCase(pInput.MiddleName);
    SELF := pInput;
End;

OrigDataset := X.File_Persons.File;
UpDS := PROJECT(OrigDataset, toUpperPlease(LEFT));
a := OUTPUT(UpDS,, '~ONLINE::allysson::Shceduled', OVERWRITE);
NewPersons := DATASET('~ONLINE::allysson::Scheduled', X.File_Persons.Layout, THOR);
b := BUILD(NewPersons, {LastName, FirstName}, {NewPersons}, '~ONLINE::allysson::NewPersonsKey', OVERWRITE);

EXPORT ProcessPersons := SEQUENTIAL(a,b);