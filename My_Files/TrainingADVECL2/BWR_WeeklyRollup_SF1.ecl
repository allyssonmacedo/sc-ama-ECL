IMPORT $, STD;

SEQUENTIAL(
    OUTPUT($.File_AllData.DailyDS,,'~ONLINE::allysson::out::WeeklyRollup1', overwrite),
    STD.File.StartSuperFileTransaction(),
        STD.File.AddSuperFile($.File_AllData.WeeklySF, '~ONLINE::allysson::out::WeeklyRollup1'),
        STD.File.ClearSuperFile($.File_AllData.AllDataSF),
    STD.File.FinishSuperFileTransaction());
