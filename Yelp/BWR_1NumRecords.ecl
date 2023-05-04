// W20230216-154339

IMPORT $;

Num_Rec_Business := COUNT($.Dataset_Business.File);
Num_Rec_Checkin  := COUNT($.Dataset_Checkin.File);
Num_Rec_Review   := COUNT($.Dataset_Review.File);
Num_Rec_Tip      := COUNT($.Dataset_Tip.File);
Num_Rec_User     := COUNT($.Dataset_User.File);


Num_Records_Dataset := DATASET([{'Business', Num_Rec_Business},
                                {'Checkin', Num_Rec_Checkin},
                                {'Review', Num_Rec_Review},
                                {'Tip', Num_Rec_Tip},
                                {'User', Num_Rec_User}],
                                {STRING15 Table_Name, INTEGER Total_Records});


OUTPUT(Num_Records_Dataset,, NAMED('Num_Records'));