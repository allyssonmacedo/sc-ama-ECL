IMPORT $;
IMPORT My_Files.OnlineRoxie As OnlineRoxie;
// modify the Fecth_Persons_LFname.ecl

basefile := OnlineRoxie.File_Persons_Slim.FilePlus;
basekey := OnlineRoxie.File_Persons_Slim.IDX_lname_fname;
cszfile := OnlineRoxie.File_LookupCSZ.FilePlus;
EXPORT Get_Persons_LFnameEx3($.iLnameFname Parms) := FUNCTION
  FilteredKey := IF(Parms.FirstName = '',
                    basekey(LastName = Parms.LastName),
                    basekey(LastName = Parms.LastName, FirstName=Parms.FirstName));
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
