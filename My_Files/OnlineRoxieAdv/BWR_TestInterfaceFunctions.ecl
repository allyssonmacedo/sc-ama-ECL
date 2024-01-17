IMPORT $;

Parms1 := MODULE($.iLnameFname)
    EXPORT LastName := 'SMITH';
END;

Parms2 := MODULE($.iState)
EXPORT State := 'PA';
END;

OUTPUT($.Get_Persons_StateLFnameEx4(Parms1, Parms2));