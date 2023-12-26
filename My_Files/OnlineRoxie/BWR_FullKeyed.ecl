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

OutRec Xform($.File_NamesPhones.File L, $.File_NamesPhonesUpd.FilePlus R) := TRANSFORM
    SELF.New_HomePhone := R.HomePhone;
    SELF.New_CellPhone := R.CellPhone;
    SELF.New_FName := R.FName;
    SELF.New_MName := R.MName;
    SELF.New_LName := R.LName;
    SELF := L;
END;

//FULL KEYED JOIN - Uses FilePlus as RIGHT RecordSet, KEYED(index) option
KeyedJoin := JOIN($.File_NamesPhones.File(LName[1] = 'L'), $.File_NamesPhonesUpd.FilePlus,
                    LEFT.RecID = RIGHT.ForeignKeyID, Xform(LEFT, RIGHT),
                    KEYED($.File_NamesPhonesUpd.IDX_Fkey_RecID));

OUTPUT(KeyedJoin,, '~ONLINE::allysson::JOIN::FullKeyed', OVERWRITE);
