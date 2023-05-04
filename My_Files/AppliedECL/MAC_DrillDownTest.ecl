IMPORT AppliedECL;

EXPORT MAC_DrilldownTest(xmlRow) := MACRO
    #WORKUNIT('name', 'Drilldown');
    // this is an example of a drilldown for multiple rows
    STRING myxmlText := xmlRow;
    LOADXML(myxmlText);
    #DECLARE(OutputStr)
    #SET(OutputStr, '' )
    #FOR(row)
        #APPEND(OutputStr, 'OUTPUT(AppliedECL.File_PersonsAccounts.PersonsParent(recid=' + %'recid'% + '));\n')
        #APPEND(OutputStr, 'OUTPUT(AppliedECL.File_PersonsAccounts.Accounts(PersonId=' + %'recid'% + '));\n' )
    #END
    %OutputStr%
ENDMACRO;