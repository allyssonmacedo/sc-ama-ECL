IMPORT $;

People := $.File_PeopleAll.People;
OUTPUT(COUNT(People($.PropBath_3 > 0)), NAMED('FourA_21561'));

OUTPUT(COUNT(People($.PropTaxBeds3 > 0)), NAMED('FourC_26549'));

OUTPUT(COUNT(People($.PropValSmallStreet > 0)), NAMED('FourD_20501'));

OUTPUT(COUNT(People($.PropTaxBedYearRange > 0)), NAMED('Five_23880'));

OUTPUT(COUNT(People($.VehicleNewTruckPrice <> '')), NAMED('six_6462'));

OUTPUT(COUNT(People($.PropTaxDataHomeAssess <> '')), NAMED('seven_25722'));

OUTPUT(COUNT(People($.CountUniqueMakeVehicles > 0)), NAMED('Eight_27900'));

OUTPUT(COUNT(People($.FordChevWithin90 > 0 )), NAMED('Nine_572'));

OUTPUT(COUNT(People($.FordChevWithin90Alternate > 0 )), NAMED('Nine2_572'));