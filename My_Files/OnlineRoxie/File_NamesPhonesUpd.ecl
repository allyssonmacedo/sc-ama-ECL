IMPORT $;

EXPORT File_NamesPhonesUpd := MODULE
  EXPORT Layout := RECORD
    UNSIGNED4 RecID;
    UNSIGNED4 ForeignKeyID;
    STRING10 HomePhone;
    STRING10 CellPhone;
    STRING20 FName;
    STRING20 MName;
    STRING20 LName;
    STRING5 Name_Suffix;
  END;

  SHARED Filename := '~online::allysson::roxie::namephonesupd';
  EXPORT File := DATASET(Filename, Layout, THOR);
  EXPORT FilePlus := DATASET(Filename, {Layout, UNSIGNED8 RecPos{VIRTUAL(fileposition)}}, THOR);
  EXPORT IDX_Fkey_RecID := INDEX(FilePlus, {ForeignKeyID, RecID, RecPos}, '~online::allysson::IDX::AllDataIDX');

END;