IMPORT $;
Property := $.File_PeopleAll.Property;
Total := $.File_PeopleAll.Property.Total_value;
Assessed := $.File_PeopleAll.Property.Assessed_value;

isSmallStreet := Property.StreetType IN ['CT', 'LN', 'WAY', 'CIR', 'PL', 'TRL'];
HighValue := IF($.IsValidAmount(Total) AND $.IsValidAmount(Assessed),
IF(Total > Assessed, Total, Assessed), 
IF($.IsValidAmount(Total), Total, Assessed));

SmallProperties := Property(IsSmallStreet, $.IsValidAmount(HighValue));
EXPORT PropValSmallStreet := IF(NOT EXISTS(SmallProperties), -9, SUM(SmallProperties, HighValue));