IMPORT $;
EXPORT DenormPeopleVehicles := MODULE
    EXPORT Layout_PeopleVehicles := RECORD 
        $.File_People.Layout;
        UNSIGNED1 ChildVCount;
        DATASET($.File_Vehicle.Layout) VehicleRecs{MAXCOUNT(20)};
    END;

    Layout_PeopleVehicles ParentMove($.File_People.Layout Le) := TRANSFORM
        SELF.ChildVCount := 0;
        SELF.VehicleRecs := [];
        SELF := Le;
    END;

    ParentOnly := PROJECT($.File_People.File, ParentMove(LEFT));

    Layout_PeopleVehicles ChildMove(Layout_PeopleVehicles Le, $.File_Vehicle.Layout Ri, INTEGER Cnt) := TRANSFORM
        SELF.ChildVCount := Cnt;
        SELF.VehicleRecs := Le.VehicleRecs + Ri;
        SELF := Le;
    END;

    EXPORT File := DENORMALIZE(ParentOnly, $.File_Vehicle.File, LEFT.id = RIGHT.personid, ChildMove(LEFT, RIGHT, COUNTER))
    : PERSIST('~ONLINE::allysson::PERSIST::PeopleVehicles');
    
END;