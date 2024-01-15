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

IDXPay := $.File_NamesPhonesUpd.IDX_Fkey_RecIDpay;
BaseDataIDX := $.File_NamesPhones.IDX_LName_Pay;

OutRec Xform3($.File_NamesPhones.File L, IDXpay R) := TRANSFORM
    SELF.New_HomePhone := R.HomePhone;
    SELF.New_CellPhone := R.CellPhone;
    SELF.New_FName := R.FName;
    SELF.New_MName := R.MName;
    SELF.New_LName := R.LName;
    SELF := L;
END;

HalfKeyedPayJoin := JOIN(BaseDataIDX(KEYED(LName[1] = 'L')), IDXpay, KEYED (LEFT.RecID = RIGHT.ForeignKeyID), Xform3(LEFT,RIGHT));

OUTPUT(HalfKeyedPayJoin,,'~ONLINE::allysson::HalfKeyedPayLoadRoxie', OVERWRITE)