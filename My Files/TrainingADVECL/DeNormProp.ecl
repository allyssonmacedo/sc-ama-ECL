IMPORT $;
EXPORT DeNormProp := MODULE
    EXPORT Layout_PropTax := RECORD 
        $.File_Property.Layout;
        UNSIGNED1 ChildTaxCount;
        DATASET($.File_taxdata.Layout) TaxRecs{MAXCOUNT(20)};
    END;

    Layout_PropTax ParentMove($.File_Property.Layout Le) := TRANSFORM
        SELF.ChildTaxCount := 0;
        SELF.TaxRecs := [];
        SELF := Le;
    END;

    ParentOnly := PROJECT($.File_Property.File, ParentMove(LEFT));

    Layout_PropTax ChildMove(Layout_PropTax Le, $.File_Taxdata.Layout Ri, INTEGER Cnt) := TRANSFORM
        SELF.ChildTaxCount := Cnt;
        SELF.TaxRecs := Le.TaxRecs + Ri;
        SELF := Le;
    END;

    EXPORT File := DENORMALIZE(ParentOnly, $.File_TaxData.File, LEFT.propertyid = RIGHT.propertyid, ChildMove(LEFT, RIGHT, COUNTER))
    : PERSIST('~ONLINE::allysson::PERSIST::PropTax');
    
END;