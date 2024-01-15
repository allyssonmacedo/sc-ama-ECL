IMPORT $;
EXPORT File_NamesPhones := MODULE
  REC := RECORD
    UNSIGNED4 RecID;
    STRING25 Address1;
    STRING25 Address2;
    STRING20 OrigCity;
    STRING2 OrigState;
    STRING9 OrigZip;
    STRING35 Country;
    STRING8 DOB;
    STRING8 Gender;
    STRING10 HomePhone;
    STRING10 CellPhone;
    STRING5 Title;
    STRING20 FName;
    STRING20 MName;
    STRING20 LName;
    STRING5 Name_Suffix;
  END;

  EXPORT File := DATASET('~online::allysson::Roxie::NamePhones', Rec, THOR);

  EXPORT IDX_LName_Pay := INDEX(FIle, {lname}, {File}, '~ONLINE::allysson::IDX::LinkDataPayLoadIDX');
END;