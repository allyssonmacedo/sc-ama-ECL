IMPORT AppliedECL AS X;
t    := TABLE(X.Persons,{BureauCode});
dt   := DISTRIBUTE(t,HASH32(BureauCode));
sdt  := SORT(dt,BureauCode,LOCAL);
dsdt := DEDUP(sdt,BureauCode,LOCAL);
COUNT(dsdt);
