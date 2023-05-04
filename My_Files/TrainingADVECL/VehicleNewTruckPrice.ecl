IMPORT $;

Vehicle := $.File_PeopleAll.Vehicle;
IsTruck := Vehicle.Vehicle_type IN ['4', 'T', 'TK', 'TR', 'TRK', 'TRUK'];
BestYear := IF($.IsValidYear(Vehicle.model_year), Vehicle.model_year, Vehicle.Best_model_year);

Trucks := Vehicle(isTruck, $.IsValidyear(BestYear), $.IsValidAmount(Vina_price));

SortedTrucks := SORT(Trucks, -BestYear, -Vina_price);

EXPORT STRING6 VehicleNewTruckPrice := IF(NOT EXISTS (SortedTrucks), '', (STRING6) SortedTrucks[1].Vina_price);