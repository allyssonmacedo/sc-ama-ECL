IMPORT AppliedECL AS X;

//X.FM_Field_Cardinality(X.Persons,  BureauCode);

//X.FM_FieldValueCount(X.Persons, Gender);

//X.FM_Field_Cardinality(X.Persons, Bureaucode);

X.MAC_Field_Cardinality(X.Persons, BureauCode);

X.MAC_Field_ValueCount(X.Persons, BureauCode);

X.Mac_Field_Population(X.Persons, Gender, 'M');

