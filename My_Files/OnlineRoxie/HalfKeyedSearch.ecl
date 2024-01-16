IMPORT $;

OutRec := RECORD
    UNSIGNED4 RecID;
    STRING10 Homephone;
    STRING10 Cellphone;
    STRING20 FName;
    STRING20 MName;
    STRING20 LName;
    STRING10 New_HomePhone;
    STRING20 New_CellPhone;
    STRING20 New_FName;
    STRING20 New_MName;
    STRING20 New_LName;
END;

IDXpay := $.File_NamesPhonesUpd.IDX_Fkey_RecIDpay;
LinkDataIDX := $.File_NamesPhones.IDX_LName_Pay;

EXPORT HalfkeyedSearch() := FUNCTION
    STRING StartsWith := '' :STORED('StartsWith');
    OutRec Xform3(LinkDataIDX L, IDXpay R) := TRANSFORM
        SELF.New_HomePhone := R.HomePhone;
        SELF.New_CellPhone := R.CellPhone;
        SELF.New_FName := R.FName;
        SELF.New_MName := R.MName;
        SELF.New_LName := R.LName;
        SELF := L;
    END;

    HalfKeyedPayJoin := JOIN(LinkDataIDX(KEYED(LName[1..LENGTH(StartsWith)] = StartsWith)), IDXpay,
                                        KEYED(LEFT.RecID = RIGHT.ForeignKeyID), Xform3(LEFT, RIGHT));
    RETURN OUTPUT(HalfKeyedPayJoin);
END;

// Target roxie e depois compile e dps publish no ecl watch. mudar a porta para 8002
// ESP - Enterprise Service Platform