IMPORT $;

// Ao invés de colocarar para rodar (submit) colocar para compilar
EXPORT PersonsFIleSearchService() := FUNCTION
  STRING15 FName_Value := '' : STORED('FirstName');
  STRING25 LName_Value := '' : STORED('LastName');
  STRING2 State_Value := '' : STORED('State');
  STRING1 Sex_Value := '' : STORED('Sex');

 Fetched := IF(State_Value <> '', 
               $.Fetch_Persons_StateLFname(State_Value, 
                                            LName_Value,
                                            FName_Value),
               $.Fetch_Persons_LFname(LName_Value, 
                                      FName_Value));
  Filter := Sex_Value = '' OR Fetched.Gender = Sex_Value;

  RETURN OUTPUT(Fetched(Filter)); 
END;