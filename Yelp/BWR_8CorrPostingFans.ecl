// W20230215-103223
IMPORT $;

Layout_review := RECORD
    $.Dataset_Review.File.user_id;
    $.Dataset_Review.File.review_id;
END;

Layout_user := RECORD
    $.Dataset_User.File.user_id;
    $.Dataset_User.File.fans;
END;

// create a slice in the recordset
Table_Review := TABLE($.Dataset_Review.File, Layout_review);
// create a crosstab report of each user_id
count_reviews := TABLE(Table_Review, {user_id, ctn_reviews := COUNT(GROUP)}, user_id);
//OUTPUT(count_reviews[..750], named('test_count'));

Table_User   := TABLE($.Dataset_User.File, Layout_user);

Join_tables := JOIN(count_reviews, Table_User,
                    LEFT.user_id = RIGHT.user_id);

OUTPUT(Join_tables, NAMED('Table'));

// correlation between count_reviews and fans:
corr := CORRELATION(Join_tables, ctn_reviews, fans);

OUTPUT(corr,NAMED('Correlation'));  // result 0.1783