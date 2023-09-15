r := RECORD
    INTEGER2 code;
    STRING110 description;
    STRING42 zone;
END;

d := DATASET('~advanced2::timezones.xml', r, XML('Dataset/area'));

OUTPUT(d);