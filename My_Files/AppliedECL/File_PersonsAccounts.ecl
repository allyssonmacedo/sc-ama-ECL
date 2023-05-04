IMPORT AppliedECL;
EXPORT File_PersonsAccounts := MODULE
EXPORT ParentRec := RECORD
 UNSIGNED8 RecID;
 STRING15  FirstName;
 STRING25  LastName;
 STRING15  MiddleName;
 STRING2   NameSuffix;
 STRING8   FileDate;
 UNSIGNED2 BureauCode;
 STRING1   MaritalStatus;
 STRING1   Gender;
 UNSIGNED1 DependentCount;
 STRING8   BirthDate;
 STRING42  StreetAddress;
 STRING20  City;
 STRING2   State;
 STRING5   ZipCode;
END;
EXPORT ChildRec := RECORD
  UNSIGNED8 PersonID;
  STRING8   ReportDate;
  STRING2   IndustryCode;
  UNSIGNED4 Member;
  STRING8   OpenDate;
  STRING1   TradeType;
  STRING1   TradeRate;
  UNSIGNED1 Narr1;
  UNSIGNED1 Narr2;
  UNSIGNED4 HighCredit;
  UNSIGNED4 Balance;
  UNSIGNED2 Terms;
  UNSIGNED1 TermTypeR;
  STRING20  AccountNumber;
  STRING8   LastActivityDate;
  UNSIGNED1 Late30Day;
  UNSIGNED1 Late60Day;
  UNSIGNED1 Late90Day;
  STRING1   TermType;
 END;
EXPORT Layout := RECORD
  ParentRec;
	INTEGER AcctCnt;
  DATASET(ChildRec) ChildAccts;
END;
EXPORT Persons  := DATASET('~ONLINE::XXX::AppliedECL::PersonsAccts',Layout,THOR);
EXPORT PersonsParent := PROJECT(Persons,ParentRec):PERSIST('~ONLINE::PERSIST::PersonsParent');	
EXPORT Accounts := Persons.ChildAccts;
END;
