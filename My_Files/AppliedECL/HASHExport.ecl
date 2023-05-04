LOADXML('<xml/>');
r := RECORD
  UNSIGNED4 id;
  STRING10  name; 
  END;
ds := DATASET([{1234,'Bob'},{5678,'Jim'}], r);  
#DECLARE(out);
#EXPORT(out, r);
OUTPUT(%'out'%);
