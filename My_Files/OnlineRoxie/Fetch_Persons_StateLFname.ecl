IMPORT $;
basefile := $.File_Persons_Slim.FilePlus;
basekey := $.File_Persons_Slim.IDX_CSZ_lname_fname;
cszfile := $.File_LookupCSZ.FilePlus;
cszkey := $.File_LookupCSZ.IDX_st_city;

EXPORT Fetch_Persons_StateLFname(STRING2 s_key, STRING l_key, STRING15 f_key) := FUNCTION
  StateRecs := Fetch(cszfile, cszkey(State=s_key), RIGHT.RecPos);
  SetCSZ_IDs := SET(StateRecs, CSZ_ID);
  FilteredKey := IF(f_key = '', basekey(CSZ_ID IN SetCSZ_IDs, LastName = l_key),
                                basekey(CSZ_ID IN SetCSZ_IDs, LastName = l_key, FirstName = f_key));

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