// W20230216-152640
IMPORT $;

choosen_city := 'Ambler';
city := $.Dataset_Business.File(city = choosen_city);

//OUTPUT(city, NAMED('city'));

RULE category := ['Restaurants'];

ds := RECORD
          city;
          STRING category_analized := MATCHTEXT(category);
END;

city_category := PARSE(city, categories, category, ds, BEST, NOCASE);
//OUTPUT(city_category, NAMED('city_category'));

// filtering the business with 2-3 and 4-5 stars
star2_3 := city_category(stars >= 2 AND stars <= 3);
star4_5 := city_category(stars >= 4 AND stars <= 5);

// filtering the opened business
is_open2_3 := star2_3(is_open);
is_open4_5 := star4_5(is_open);

// filtering the closed business
is_closed2_3 := star2_3(NOT is_open);
is_closed4_5 := star4_5(NOT is_open);

//OUTPUT(star2_3, NAMED('star2_3'));
//OUTPUT(star4_5, NAMED('star4_5'));

//OUTPUT(is_open2_3, NAMED('is_open2_3'));
//OUTPUT(is_open4_5, NAMED('is_open4_5'));

//OUTPUT(is_closed2_3, NAMED('is_closed2_3'));
//OUTPUT(is_closed4_5, NAMED('is_closed4_5'));

count_reviews := DATASET([{'star2_3', 'both', AVE(star2_3, review_count)},
                          {'star2_3', 'open', AVE(is_open2_3, review_count)},
                          {'star2_3', 'closed', AVE(is_closed2_3, review_count)},
                          {'star4_5', 'both', AVE(star4_5, review_count)},
                          {'star4_5', 'open', AVE(is_open4_5, review_count)},
                          {'star5_5', 'closed', AVE(is_closed4_5, review_count)}],
                          {STRING15 review, STRING status, UNSIGNED4 cnt_reviews});

//OUTPUT(count_reviews, NAMED('count_reviews'));

import STD;

tst := RECORD
    is_open2_3;
    integer ctn := STD.Str.CountWords(is_open2_3.categories,',');
    //COUNT((is_open2_3.categories IN [',']));
END;

ds2 := table(is_open2_3, tst);
ds2;

tst2 := RECORD
    is_open2_3;
    ctn := STD.Str.SplitWords(is_open2_3.address, ' ');
    //COUNT((is_open2_3.categories IN [',']));
END;

ds3 := table(is_open2_3, tst2);
ds3;

tst3 := RECORD
    is_open2_3;
    ctn :=STD.Str.SplitWords(is_open2_3.address, ' ')[2..];
    //COUNT((is_open2_3.categories IN [',']));
END;

ds4 := table(is_open2_3, tst3);
ds4;














/////
/*
// W20230216-152640
IMPORT $, STD;

// chosing the city and the category for the analysis
choosen_city := 'Ambler';
choosen_category := 'Restaurants';

// filtering the city
city := $.Dataset_Business.File(city = choosen_city);

// Is it a business from the choosen category?
layout_is_category := RECORD 
          city;
          is_category := STD.Str.FindWord(city.categories, choosen_category);
    END;
business_category := TABLE(city, layout_is_category)(is_category); // filtering the true values
OUTPUT(business_category, NAMED('business_category'));

// Segregrating the data into two groups : 2-3 and 4-5 stars
bc_star2_3 := business_category(stars >= 2 AND stars <= 3);
bc_star4_5 := business_category(stars >= 4 AND stars <= 5);
OUTPUT(bc_star2_3, NAMED('star2_3'));
OUTPUT(bc_star4_5, NAMED('star4_5'));


// filtering the opened business
is_open2_3 := bc_star2_3(is_open);
is_open4_5 := bc_star4_5(is_open);
// filtering the closed business
is_closed2_3 := bc_star2_3(NOT is_open);
is_closed4_5 := bc_star4_5(NOT is_open);

count_reviews := DATASET([{'star2_3', 'open and closed', SUM(bc_star2_3, review_count), AVE(bc_star2_3, review_count)},
                          {'star4_5', 'open and closed', SUM(bc_star4_5, review_count), AVE(bc_star4_5, review_count)},
                          {'star2_3', 'open', SUM(is_open2_3, review_count), AVE(is_open2_3, review_count)},
                          {'star2_3', 'closed', SUM(is_closed2_3, review_count), AVE(bc(), review_count)},
                          {'star4_5', 'open', SUM(bc_star2_3, review_count), AVE(is_open4_5, review_count)},
                          {'star4_5', 'closed', SUM(bc_star2_3, review_count), AVE(is_closed4_5, review_count)}],
                          {STRING15 range_stars, STRING status, UNSIGNED4 cnt_reviews, DECIMAL5_2 avg_reviews});

OUTPUT(count_reviews, NAMED('count_reviews'));


city;

OUTPUT(city, NAMED('city'));

RULE category := choosen_category;

ds := RECORD
          city;
          STRING category_analized := MATCHTEXT(category);
END;

city_category := PARSE(city, categories, category, ds, BEST, NOCASE);
OUTPUT(city_category, NAMED('city_category'));

// filtering the business with 2-3 and 4-5 stars
star2_3 := city_category(stars >= 2 AND stars <= 3);
star4_5 := city_category(stars >= 4 AND stars <= 5);

// filtering the opened business
is_open2_3 := star2_3(is_open);
is_open4_5 := star4_5(is_open);

// filtering the closed business
is_closed2_3 := star2_3(NOT is_open);
is_closed4_5 := star4_5(NOT is_open);

OUTPUT(star2_3, NAMED('star2_3'));
OUTPUT(star4_5, NAMED('star4_5'));

OUTPUT(is_open2_3, NAMED('is_open2_3'));
OUTPUT(is_open4_5, NAMED('is_open4_5'));

OUTPUT(is_closed2_3, NAMED('is_closed2_3'));
OUTPUT(is_closed4_5, NAMED('is_closed4_5'));

count_reviews := DATASET([{'star2_3', 'both', AVE(star2_3, review_count)},
                          {'star2_3', 'open', AVE(is_open2_3, review_count)},
                          {'star2_3', 'closed', AVE(is_closed2_3, review_count)},
                          {'star4_5', 'both', AVE(star4_5, review_count)},
                          {'star4_5', 'open', AVE(is_open4_5, review_count)},
                          {'star5_5', 'closed', AVE(is_closed4_5, review_count)}],
                          {STRING15 review, STRING status, UNSIGNED4 cnt_reviews});

OUTPUT(count_reviews, NAMED('count_reviews'));
///////

tst := RECORD
    is_open2_3;
    integer ctn := COUNT((is_open2_3.categories IN [',']));
END;

// ds := table(is_open2_3, tst);
*/