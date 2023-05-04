IMPORT $;

SortedVehicles := SORT($.File_PeopleAll.Vehicle, Make_code);

DedupVehicles := DEDUP(SortedVehicles, Make_code);

EXPORT CountUniqueMakeVehicles := IF( NOT EXISTS(DedupVehicles), -9, COUNT(DedupVehicles));

