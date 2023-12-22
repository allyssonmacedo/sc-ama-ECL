IMPORT $;
basefile := $.File_Persons_Slim.FilePlus;
basekey := $.File_Persons_Slim.IDX_lname_fname;
cszfile := $.File_LookupCSZ.FilePlus;
EXPORT Fetch_Persons_LFname(STRING25 l_key, STRING15 f_key) := FUNCTION
  FilteredKey := IF(f_key = '',
                    basekey(LastName = l_key),
                    basekey(LastName = l_key, FirstName=f_key));
  Fetch_Persons := FETCH(basefile, FilteredKey, RIGHT.RecPos);

  OutRec := RECORD 
    RECORDOF(basefile) AND NOT [RecPos, CSZ_ID];
    RECORDOF(cszfile) AND NOT [RecPos, CSZ_ID];
  END;

  OutRec JoinEm(cszfile Le, basefile Ri) := TRANSFORM
    SELF := Le;
    SELF := Ri;
  END;
  
  RETURN JOIN(cszfile, Fetch_Persons, 
             LEFT.CSZ_ID = RIGHT.CSZ_ID,
             JoinEm(LEFT, RIGHT), ALL);
END;
