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

AllDataDS := $.File_NamesPhonesUpd.FilePlus;
INDX := $.File_NamesPhonesUpd.IDX_Fkey_RecID;

OutRecPlus := RECORD(OutRec)
    UNSIGNED4 ForeignKeyID; //needed for fetch link
END;

OutRecPlus Xform1($.File_NamesPhones.File L, INDX R) := TRANSFORM
    SELF.ForeignKeyID := R.RecID;
    SELF := L;
    SELF := [];
END;

HalfKeyedJoin := JOIN($.File_NamesPhones.File(LName[1]='L'), INDX, LEFT.RecID=RIGHT.ForeignKeyID, Xform1(LEFT,RIGHT));

SetRecs := SET(HalfKeyedJoin, RecID);
FetchedRecs := FETCH(AllDataDS, INDX(ForeignKeyID IN SetRecs), RIGHT.RecPos);

OutRec Xform2(OutRecPlus L, AllDataDS R) := TRANSFORM
    SELF.New_HomePhone := R.HomePhone;
    SELF.New_CellPhone := R.CellPhone;
    SELF.New_FName := R.FName;
    SELF.New_MName := R.MName;
    SELF.New_LName := R.LName;
    SELF := L;
END;

Result := JOIN(HalfKeyedJoin, FetchedRecs, 
    LEFT.ForeignKeyID = RIGHT.RecID,
    Xform2(LEFT, RIGHT));

OUTPUT(Result,, '~ONLINE::allysson::JOIN::HalfKeyed', OVERWRITE);

COUNT(Result);