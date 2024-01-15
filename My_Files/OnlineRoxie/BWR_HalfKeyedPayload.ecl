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
BaseDS := $.File_NamesPhones.File;

OutRec Xform3($.File_NamesPhones.File Le, IDXpay Ri) := TRANSFORM
    SELF.New_HomePhone := Ri.HomePhone;
    SELF.New_CellPhone := Ri.CellPhone;
    SELF.New_FName := Ri.FName;
    SELF.New_MName := Ri.MName;
    SELF.New_LName := Ri.LName;
    SELF := Le;
END;

HalfKeyedPayJoin := JOIN($.File_NamesPhones.File, IDXpay, KEYED (LEFT.RecID = RIGHT.ForeignKeyID) AND
    LEFT.lname[1] = 'L',
    Xform3(LEFT, RIGHT));

OUTPUT(HalfKeyedPayJoin,,'~ONLINE::allysson::HalfKeyedPayLoad', OVERWRITE)