IMPORT $;

EXPORT File_PeopleAll := MODULE
    EXPORT People := DATASET('~ONLINE::allysson::OUT::PeopleAll', $.Denorm_PeopleAll.Layout_PeopleAll, THOR);

    EXPORT Vehicle := People.Vehiclerecs;
    EXPORT Property := People.PropRecs;
    EXPORT Taxdata := People.PropRecs.TaxRecs;
END;
    