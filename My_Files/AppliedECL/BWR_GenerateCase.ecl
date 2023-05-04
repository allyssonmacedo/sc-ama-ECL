IMPORT STD;
IMPORT AppliedECL AS X;
UpperIt(STRING txt) := Std.Str.ToUpperCase(txt);
ded := DEDUP(SORT(X.File_States.File, StateCode), StateCode);
r := RECORD
    STRING Val := (STRING)ded.StateCode + ' => \'' + TRIM((STRING)ded.State) + '\'';
    STRING RVal := '\'' + UpperIt(TRIM((STRING)ded.State)) + '\' => ' +(STRING)ded.StateCode;
    END;
r Conc(r L, r R) := TRANSFORM
    SELF.Val := L.Val + ',' + R.Val;
    SELF.RVal := L.RVal + ',' + R.RVal;
    END;
s := ROLLUP(TABLE(ded, r), TRUE, Conc(LEFT, RIGHT));
OutVal := 'IntTo' + 'State'+'(INTEGER i) := CASE(i, '+ s[1].Val+',\'?\');';
ROutVal := 'State' + 'ToInt(STRING s) := CASE(X.ToUpperCase(s), '+s[1].RVal+',0);';
s;
OutVal;
ROutVal;

