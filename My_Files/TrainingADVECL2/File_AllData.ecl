EXPORT File_AllData := MODULE
    EXPORT AllDataSF := '~ONLINE::allysson::SF::Alldata';
    EXPORT WeeklySF := '~ONLINE::allysson::SF::weekly';
    EXPORT DailySF := '~ONLINE::allysson::SF::daily';

    EXPORT Base1 := '~ecltraining2::onlinenamephonesupd1';

    EXPORT Base2 := '~ONLINE::allysson::out::NewWeeklyRollup1';

// Layout

SHARED Rec := RECORD
    UNSIGNED4 recid;
    UNSIGNED4 foreignkey;
    STRING10 homephone;
    STRING10 cellphone;
    STRING20 fname;
    STRING20 mname;
    STRING20 lname;
    STRING5 name_suffix;
END;

EXPORT AllDataDS := DATASET(AllDataSF, Rec, THOR);
EXPORT WeeklyDS := DATASET(WeeklySF, Rec, THOR);
EXPORT DailyDS := DATASET(DailySF, Rec, THOR);

END;