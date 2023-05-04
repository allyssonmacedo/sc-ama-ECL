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

// simple counting the count_reviews of business with 2-3 and 4-5 stars
count_reviews := DATASET([{'star2_3', 'open and closed', SUM(bc_star2_3, review_count), AVE(bc_star2_3, review_count)},
                          {'star4_5', 'open and closed', SUM(bc_star4_5, review_count), AVE(bc_star4_5, review_count)}],
                          {STRING15 range_stars, STRING status, UNSIGNED4 sum_reviews, DECIMAL5_2 avg_num_reviews});
OUTPUT(count_reviews, NAMED('reviews_tbl_1_2'));