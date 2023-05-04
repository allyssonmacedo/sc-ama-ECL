EXPORT File_States := MODULE
 EXPORT Layout := RECORD
  STRING2   State;
  UNSIGNED1 StateCode;
 END;
 EXPORT File := DATASET('~ONLINE::AppliedECL::States',Layout,THOR); 
 
END;
