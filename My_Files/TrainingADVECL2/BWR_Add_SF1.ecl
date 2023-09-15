IMPORT $, STD;
SEQUENTIAL(
    STD.File.StartSuperFileTransaction(),
    STD.File.AddSuperFile($.File_AllData.AllDataSF, $.File_AllData.WeeklySF),
    STD.File.AddSuperFile($.File_AllData.AllDataSF, $.File_AllData.DailySF),
    STD.File.AddSuperFile($.File_AllData.AllDataSF, $.File_AllData.Base1),
    STD.File.FinishSuperFileTransaction()
);