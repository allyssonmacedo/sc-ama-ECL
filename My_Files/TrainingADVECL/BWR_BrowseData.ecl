IMPORT TrainingADVECL AS x;

OUTPUT(x.File_People.File, NAMED('People_In'));
OUTPUT(x.File_Vehicle.File, NAMED('Vehicle_In'));
OUTPUT(x.File_Property.File, NAMED('Property_In'));
OUTPUT(x.File_Taxdata.File, NAMED('Taxdata_In'));

OUTPUT(x.File_PeopleAll.People, NAMED('People'));
OUTPUT(x.File_PeopleAll.Vehicle, NAMED('Vehicle'));
OUTPUT(x.File_PeopleAll.Property, NAMED('Property'));
OUTPUT(x.File_PeopleAll.Taxdata, NAMED('Taxdata'));