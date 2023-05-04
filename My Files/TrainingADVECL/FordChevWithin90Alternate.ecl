IMPORT $, STD;

Vehicle := $.File_PeopleAll.Vehicle;
isDateWithin (STRING fdate, STRING sdate):= ABS($.Z2JD(fdate) - $.Z2JD(sdate)) <= 90;

jn := JOIN(Vehicle, Vehicle, (LEFT.make_description = 'Ford' AND RIGHT.make_description = 'Chevrolet' AND IsDateWithin(LEFT.purch_date, RIGHT.purch_date)), ALL);

cntTypeWithin := COUNT(jn);

retVal := IF(cntTypeWithin > 0, cntTypeWithin, -9);

EXPORT FordChevWithin90Alternate := retVal;
