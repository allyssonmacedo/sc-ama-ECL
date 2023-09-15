IMPORT $, STD;

Daily := $.File_AllData.DailySF;
SEQUENTIAL(
    STD.File.StartSuperFileTransaction(),
    STD.File.AddSuperFile(Daily, '~ecltraining2::onlinenamephonesupd2'),
    STD.File.AddSuperFile(Daily, '~ecltraining2::onlinenamephonesupd3'),
    STD.File.FinishSuperFileTransaction()
    );


