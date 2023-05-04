IMPORT $;
Property := $.File_PeopleAll.Property;
TaxData := $.File_PeopleAll.Taxdata;

IsValidBathCount(UNSIGNED2 TotalBaths) := FUNCTION
    isValidProperty:= Property.Full_baths + ROUND(Property.Half_baths/2) >= TotalBaths;
    isValidTaxdata := EXISTS(Taxdata(Full_baths + (ROUND(Half_baths/2)) >= TotalBaths));
    RETURN IsValidProperty or IsValidTaxdata;
END;

EXPORT PropBath_3 := COUNT(Property(IsValidBathCount(3)));

    