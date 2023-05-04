// W20230216-115814
IMPORT $;

business_layout:= RECORD
	$.Dataset_Business.File.business_id;
    $.Dataset_Business.File.city
END;

review_layout := RECORD
	$.Dataset_Review.File.business_id;
	$.Dataset_Review.File.stars;
    BOOLEAN is_0  := if($.Dataset_Review.File.stars < 1, 1, 0);
    BOOLEAN is_1  := if($.Dataset_Review.File.stars >= 1 AND $.Dataset_Review.File.stars < 2, 1, 0);
    BOOLEAN is_2  := if($.Dataset_Review.File.stars >= 2 AND $.Dataset_Review.File.stars < 3, 1, 0);
    BOOLEAN is_3  := if($.Dataset_Review.File.stars >= 3 AND $.Dataset_Review.File.stars < 4, 1, 0);
    BOOLEAN is_4  := if($.Dataset_Review.File.stars >= 4 AND $.Dataset_Review.File.stars < 5, 1, 0);
    BOOLEAN is_5  := if($.Dataset_Review.File.stars >= 5, 1, 0)
END;

business_tbl := TABLE($.Dataset_Business.File, business_layout);
review_tbl   := TABLE($.Dataset_Review.File, review_layout);
join_tbl     := JOIN(business_tbl, review_tbl,
                    LEFT.business_id = RIGHT.business_id);

count_tbl := RECORD
    join_tbl.city;
    REAL count_0 := SUM(GROUP, (INTEGER) join_tbl.is_0); 
    REAL count_1 := SUM(GROUP, (INTEGER) join_tbl.is_1); 
    REAL count_2 := SUM(GROUP, (INTEGER) join_tbl.is_2); 
    REAL count_3 := SUM(GROUP, (INTEGER) join_tbl.is_3); 
    REAL count_4 := SUM(GROUP, (INTEGER) join_tbl.is_4); 
    REAL count_5 := SUM(GROUP, (INTEGER) join_tbl.is_5); 
END;                    

MyTable := TABLE(join_tbl, count_tbl, city);


OUTPUT(business_tbl, NAMED('business_tbl'));
OUTPUT(review_tbl, NAMED('review_tbl'));
OUTPUT(MyTable, NAMED('statisticsOfCityStars'));