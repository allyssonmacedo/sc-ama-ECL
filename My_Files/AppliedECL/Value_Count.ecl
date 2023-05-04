IMPORT AppliedECL AS X;
r := RECORD
  X.Persons.Gender;
  INTEGER cnt := COUNT(GROUP);
  END;
EXPORT ValueCount := TABLE(X.Persons,r,Gender); 

