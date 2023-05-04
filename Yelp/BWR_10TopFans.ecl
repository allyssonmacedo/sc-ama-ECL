// W20230215-110433
IMPORT $;

// As we saw in the exercise 1 and 2, the User dataset doesn't have duplicates user_id. 
// The dataset has 1.987.897 records and all of them are distinct for the user_id key.

slice := RECORD
    $.Dataset_User.File.user_id;
    $.Dataset_User.File.name;
    $.Dataset_User.File.fans;
END;

table_sliced := TABLE($.Dataset_User.File, slice);

fans := SORT(table_sliced, -fans);

OUTPUT(fans[..10], NAMED('Top10Fans'));