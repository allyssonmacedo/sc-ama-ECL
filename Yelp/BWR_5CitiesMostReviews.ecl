// W20230215-073319

IMPORT $;

Layout_business := RECORD
  $.Dataset_Business.File.business_id;
  $.Dataset_Business.File.city;
  $.Dataset_Business.File.state;
END;

Layout_review := RECORD
  $.Dataset_Review.File.review_id;
  $.Dataset_Review.File.business_id;
  $.Dataset_Review.File.stars;
END;

Table_business := TABLE($.Dataset_Business.File, Layout_business);
Table_review   := TABLE($.Dataset_Review.File, Layout_review);

Join_tables := JOIN(Table_business, Table_review,
                    LEFT.business_id = RIGHT.business_id);
                   
                    
// create a crosstab report of each bussiness_id
count_reviews := TABLE(Join_tables, {city, ctn := COUNT(GROUP)}, city);

sorted_table := SORT(count_reviews, -ctn);

OUTPUT(sorted_table,,NAMED('Count_reviews'));
                 
             
                    