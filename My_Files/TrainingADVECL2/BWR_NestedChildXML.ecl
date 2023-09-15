Layout_accts := RECORD
    UNSIGNED8 personid;
    STRING8 reportdate;
    STRING2 industrycode;
    STRING8 opendate;
    UNSIGNED4 highcredit;
    UNSIGNED4 balance;
    UNSIGNED2 terms;
    STRING20 accountnumber;
    STRING8 lastactivitydate;
END;

// The same in the BWR_SimpleXML
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
    DATASET(layout_accts) childaccts{XPATH('childaccts/Row'), maxCount(120)};
END;

ds := DATASET('~advanced2::nestedchildxml', Layout_PeopleFile, XML('dataset/Row'));

OUTPUT(ds);