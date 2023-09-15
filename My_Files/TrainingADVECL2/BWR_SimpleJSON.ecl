Layout_PeopleFile := RECORD
    UNSIGNED8 ID;
    STRING15 FirstName;
    STRING25 LastName;
    STRING15 MiddleName;
    STRING2 NameSuffix;
    STRING8 FileDate;
    UNSIGNED2 BureauCode;
    STRING1 MaritalStatus;
    STRING1 Gender;
    UNSIGNED1 DependentCount;
    STRING8 BirthDate;
    STRING42 StreetAddress;
    STRING20 City;
    STRING State;
    STRING5 ZipCode;
END;

ds := DATASET('~advanced2::peoplefljson', Layout_PeopleFile, JSON('Row'));
OUTPUT(ds);