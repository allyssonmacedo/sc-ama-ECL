IMPORT $, STD;

SEQUENTIAL(
    STD.File.StartSuperFileTransaction(),
        STD.File.AddSuperFile($.File_AllData.DailySF, '~ecltraining2::onlinenamephonesupd4'),
        STD.File.AddSuperFile($.File_AllData.DailySF, '~ecltraining2::onlinenamephonesupd5'),
    STD.File.FinishSuperFileTransaction()
    );
