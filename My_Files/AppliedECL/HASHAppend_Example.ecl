LOADXML('<xml/>');
#DECLARE(OutputStr)
//                 OUTPUT( 'Hello ',NAMED( 'Hello '));
#APPEND(OutputStr,'OUTPUT(\'Hello\',NAMED(\'Hello\'));\n' )
%OutputStr%
#DECLARE(MySymbol)
#SET(MySymbol, 'Hello')
#APPEND(MySymbol, ' World')
%'MySymbol'%  //Will output ' Hello World '
