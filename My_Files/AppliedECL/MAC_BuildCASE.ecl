EXPORT MAC_BuildCASE (Infile, FieldText, FieldNum, OutVal, ROutVal) := MACRO
// LOADXML('<xml/>');
IMPORT Std.Str AS Z;
ded := DEDUP(SORT(Infile, FieldNum), FieldNum);

r := RECORD 
    STRING Val := (STRING)ded.FieldNum + ' => \''+TRIM((STRING)ded.FieldText) + '\''; 
    STRING RVal := '\'' + Z.ToUpperCase(TRIM((STRING)ded.FieldText)) + '\' => ' + (STRING)ded.FieldNum;
    END;

r Conc(r L, r R) := TRANSFORM 
    SELF.Val := L.Val + ',' + R.Val;
    SELF.RVal := L.RVal + ',' + R.RVal;
    END;

s := ROLLUP(TABLE(ded,r), TRUE, Conc(LEFT, RIGHT));

OutVal := 'IntTo' + #TEXT(FieldText)+' (INTEGER i) := CASE(i, '+ s[1].Val+',\'?\');';
ROutVal := #TEXT(FieldText)+'ToInt(STRING s) := CASE(Std.Str.ToUpperCase(s), 's[1].RVal+',0);';

ENDMACRO;