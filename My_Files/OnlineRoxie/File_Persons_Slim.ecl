IMPORT $, My_Files;
EXPORT File_Persons_Slim := MODULE
  EXPORT Layout := RECORD
    RECORDOF(My_Files.OnlineClass.STD_Persons.File) AND NOT [City, State, ZipCode];
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

  EXPORT IDX_lname_CSZ_payupd := INDEX(FileUpd, {LastName, CSZ_ID}, {FileUpd}, '~ONLINE::allysson::KEY::lname_fname_CSZ_payupd'); // ver imagem lab11 e lab11b

END;