IMPORT $;
$.File_Persons_Slim.Layout Slimdown($.STD_Persons.File L,
                                    $.File_LookupCSZ.File R) := TRANSFORM
  SELF.CSZ_ID := R.CSZ_ID;
  SELF := L;
END;

SlimRecs := JOIN($.STD_Persons.File, $.File_LookupCSZ.File,
  LEFT.ZipCode = RIGHT.ZipCode AND
  LEFT.city = RIGHT.city AND
  LEFT.State = RIGHT.State, Slimdown(LEFT, RIGHT), LEFT OUTER, LOOKUP);

OUTPUT(SlimRecs,,'~ONLINE::allysson::OUT::Persons_Slim', OVERWRITE);