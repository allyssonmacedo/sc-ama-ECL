 // This script processes XML and generates ECL COUNT statements
  // which run against the datasets and filters specified in the XML.
  XMLstuff :=
   '<section>'+
       '<item>'+
           '<dataset>persons</dataset>'+
           '<filter>firstname = \'RICHARD\'</filter>'+
       '</item>'+
       '<item>'+
           '<dataset>persons</dataset>'+
           '<filter>firstname = \'JOHN\'</filter>'+
       '</item>'+
       '<item>'+
           '<dataset>persons</dataset>'+
           '<filter>firstname = \'HENRY\'</filter>'+
       '</item>'+
   '</section>';
  
  LOADXML(XMLstuff);
  #DECLARE(CountStr); // Declare CountStr
  #SET(CountStr, '' ); // Initialize it to an empty string
  #FOR(item)
     #APPEND(CountStr,'COUNT(' + %'dataset'% + '(' + %'filter'% + ' ));\n');
  #END
  
  OUTPUT(%'CountStr'%); // output the string just built
  //%CountStr% // then execute the generated "COUNT" actions
  
  // Note that the "CountStr" will have 3 COUNT actions in it:
  //   COUNT(person(person.firstname = 'RICHARD'));
  //   COUNT(person(person.firstname = 'JOHN'));
  //   COUNT(person(person.firstname = 'HENRY'));
