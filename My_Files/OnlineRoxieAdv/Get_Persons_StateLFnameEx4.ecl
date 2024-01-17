IMPORT $;
IMPORT My_Files.OnlineRoxie AS OnlineRoxie;

basefile := OnlineRoxie.File_Persons_Slim.FilePlus;
basekey := OnlineRoxie.File_Persons_Slim.IDX_CSZ_lname_fname;
cszfile := OnlineRoxie.File_LookupCSZ.FilePlus;
cszkey := OnlineRoxie.File_LookupCSZ.IDX_st_city;

EXPORT Fetch_Persons_StateLFname($.iLnameFname Parms1, $.iState Parms2) := FUNCTION
  StateRecs := Fetch(cszfile, cszkey(State=Parms2.State), RIGHT.RecPos);
  SetCSZ_IDs := SET(StateRecs, CSZ_ID);
  FilteredKey := IF(Parms1.FirstName = '', basekey(CSZ_ID IN SetCSZ_IDs, LastName = Parms1.LastName),
                                basekey(CSZ_ID IN SetCSZ_IDs, LastName = Parms1.LastName, FirstName = Parms1.FirstName));

  Fetch_Persons := FETCH(basefile, FilteredKey, RIGHT.RecPos);

  OutRec := RECORD
    RECORDOF(basefile) AND NOT [RecPos, CSZ_ID];
    RECORDOF(cszfile) AND NOT [RecPos, CSZ_ID];
  END;

  OutRec JoinEm(cszfile R, basefile L) := TRANSFORM
    SELF := L;
    SELF := R;
  END;
  
  RETURN JOIN(StateRecs, Fetch_Persons, LEFT.CSZ_ID = RIGHT.CSZ_ID, JoinEm(LEFT, RIGHT), ALL);

END;