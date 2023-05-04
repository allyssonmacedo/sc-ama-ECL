IMPORT $;

EXPORT Denorm_PeopleAll := MODULE
    EXPORT Layout_PeopleAll := RECORD
        $.File_People.Layout;
        UNSIGNED1 ChildVcount;
        UNSIGNED1 ChildPcount;
        DATASET($.File_Vehicle.Layout) VehicleRecs {MAXCOUNT(20)};
        DATASET($.DenormProp.Layout_PropTax) PropRecs {MAXCOUNT(20)};
    END;

    Layout_PeopleAll ParentMove($.DenormPeopleVehicles.Layout_PeopleVehicles Le) := TRANSFORM 
        SELF.ChildPcount := 0;
        SELF.PropRecs := [];
        SELF := Le;
    END;

    ParentOnly := PROJECT($.DenormPeopleVehicles.File, ParentMove(LEFT));
    
    Layout_PeopleAll ChildMove(Layout_PeopleAll Le, $.DenormProp.Layout_Proptax Ri, INTEGER Cnt) := TRANSFORM
        SELF.ChildPcount := Cnt;
        SELF.PropRecs := Le.PropRecs + Ri;
        SELF := Le;
    END;

    EXPORT File := DENORMALIZE(ParentOnly, $.DenormProp.File, LEFT.id = RIGHT.personid, ChildMove(LEFT, RIGHT, COUNTER));
END;