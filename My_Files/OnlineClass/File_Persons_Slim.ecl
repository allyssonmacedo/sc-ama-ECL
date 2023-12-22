IMPORT $;
EXPORT File_Persons_Slim := MODULE
  EXPORT Layout := RECORD
    RECORDOF($.STD_Persons.File) AND NOT [City, State, ZipCode];
    UNSIGNED4 CSZ_ID;
  END;
  
  SHARED Filename := '~ONLINE::allysson::Roxie::Persons_Slim'; 
  EXPORT File := DATASET(Filename, Layout, FLAT);
  EXPORT FilePlus := DATASET(Filename, {Layout, UNSIGNED8 RecPos{virtual(fileposition)}}, FLAT);
  EXPORT IDX_CSZ_lname_fname := INDEX(FilePlus, 
                                      {CSZ_ID, LastName, FirstName, RecPos},
                                      '~ONLINE::allysson::KEY::CSZ_lname_fname');
  EXPORT IDX_lname_fname := INDEX(FilePlus, 
                                      {LastName, FirstName, RecPos},
                                      '~ONLINE::allysson::KEY::lname_fname');
END;