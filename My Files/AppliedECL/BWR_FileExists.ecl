IMPORT STD;
IMPORT $;

EventText := 'FileSprayed';
FileName := '~ONLINE::allysson::intro::Persons';

IF(STD.File.FileExists(FileName), STD.File.DeleteLogicalFile(Filename));
// deletes th file if it already exists

STD.File.MonitorLogicalFileName(EventText, FileName);
// sets up monitoring and the event name
// to fire when the file is found

$.ProcessPersons : WHEN(EVENT(EventText, '*'), COUNT(1));
// this OUTPUT occurs only after the event has fired