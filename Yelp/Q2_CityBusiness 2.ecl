EXPORT CityBusiness := MODULE

    SHARED choosen_city := 'Ambler';
    SHARED choosen_category := ['Restaurants'];

    EXPORT city := $.Dataset_Business.File(city = choosen_city);

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


tst := RECORD
    is_open2_3;
    integer ctn := COUNT((is_open2_3.categories IN [',']));
END;

ds := table(is_open2_3, tst);



END;



