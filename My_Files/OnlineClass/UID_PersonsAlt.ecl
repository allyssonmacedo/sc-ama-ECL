IMPORT $, Std;

// Criando a tabela com o novo layout porque o iterate as duas tabelas precisam ser mesmo tamanho
Layout_PersonsAlt := RECORD
  UNSIGNED4 UID := 0;
  $.File_Persons.File;
END;

// Criando a tabela com o novo layout porque o iterate as duas tabelas precisam ser mesmo tamanho
PersonsTbl := 
  TABLE($.File_Persons.File, 
  Layout_PersonsAlt);


// Fazendo a transformação da nova tabela
Layout_PersonsAlt IDRecs(
  Layout_PersonsAlt L,
  Layout_PersonsAlt R) := TRANSFORM
    SELF.UID := IF(L.UID=0, std.system.thorlib.node()+1, L.UID+CLUSTERSIZE); // The first node begin with 0, thus +1.
    SELF := R;
END;


EXPORT UID_PersonsAlt := ITERATE(PersonsTbl, IDRecs(LEFT, RIGHT), LOCAL)
  :PERSIST('~CLASS::allysson::PERSIST::UID_PersonsAlt');