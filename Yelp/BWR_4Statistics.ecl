// For each table and column listed below, display the smallest (minimum), largest (maximum), and average (mean) value for the following fields
// W20230216-093533
IMPORT $;

myrec := RECORD
	$.Dataset_Business.File.city;
	REAL stars_max_value := MAX(GROUP, $.Dataset_Business.File.stars);
    REAL stars_min_value := MIN(GROUP, $.Dataset_Business.File.stars);
    REAL stars_ave_value := AVE(GROUP, $.Dataset_Business.File.stars);
    REAL reviews_max_value := MAX(GROUP, $.Dataset_Business.File.review_count);
    REAL reviews_min_value := MIN(GROUP, $.Dataset_Business.File.review_count);
    REAL reviews_ave_value := AVE(GROUP, $.Dataset_Business.File.review_count);
    REAL business_name_max_length := MAX(GROUP, LENGTH($.Dataset_Business.File.name));    
    REAL busiess_name_min_length := MIN(GROUP, LENGTH($.Dataset_Business.File.name)); 
    REAL business_name_ave_length := AVE(GROUP, LENGTH($.Dataset_Business.File.name))
END;

MyTable := TABLE($.Dataset_Business.File, myrec, city);
OUTPUT(MyTable, NAMED('statisticsOfCityReview'));