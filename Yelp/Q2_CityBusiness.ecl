// W20230222-134924
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


// Counting the number of restaurants in each street
        layout_address2_3 := RECORD
            bc_star2_3;
            address_ :=STD.Str.SplitWords(bc_star2_3.address, ' ')[2..];
        END;

        address2_3 := table(bc_star2_3, layout_address2_3);
        grouped_address2_3 := TABLE(address2_3, {address_, cnt := COUNT(GROUP)}, address_);
        sorted_2_3 := SORT(grouped_address2_3, -cnt);
        OUTPUT(sorted_2_3, NAMED('sorted_grouped_address2_3'));

    // Doing the same thing for restaurants with 4-5 stars
        layout_address4_5 := RECORD
            bc_star4_5;
            address_ :=STD.Str.SplitWords(bc_star4_5.address, ' ')[2..];
        END;

        address4_5 := table(bc_star4_5, layout_address4_5);
        grouped_address4_5 := TABLE(address4_5, {address_, cnt := COUNT(GROUP)}, address_);
        sorted_4_5 := SORT(grouped_address4_5, -cnt);
        OUTPUT(sorted_4_5, NAMED('sorted_grouped_address4_5'));




    // for answering the second question

    // filtering the opened business
    is_open2_3 := bc_star2_3(is_open);
    is_open4_5 := bc_star4_5(is_open);
    // filtering the closed business
    is_closed2_3 := bc_star2_3(NOT is_open);
    is_closed4_5 := bc_star4_5(NOT is_open);

    // Statistics from open and closed restaurants, count and average of reviews and average of categories
    count_statistics := DATASET([{'star2_3', 'open and closed', SUM(bc_star2_3, review_count), AVE(bc_star2_3, review_count)},
                            {'star4_5', 'open and closed', SUM(bc_star4_5, review_count), AVE(bc_star4_5, review_count)},
                            {'star2_3', 'open', SUM(is_open2_3, review_count), AVE(is_open2_3, review_count)},
                            {'star2_3', 'closed', SUM(is_closed2_3, review_count), AVE(is_closed2_3, review_count)},
                            {'star4_5', 'open', SUM(is_open4_5, review_count), AVE(is_open4_5, review_count)},
                            {'star4_5', 'closed', SUM(is_closed4_5, review_count), AVE(is_closed4_5, review_count)}],
                            {STRING15 range_stars, STRING status, UNSIGNED4 sum_reviews, DECIMAL5_2 avg_num_reviews});
    OUTPUT(count_statistics, NAMED('basic_statistics_2'));



    // Does the number of categories and the length of the name have any correlation between closed and open? 
        layout_categories2_3 := RECORD
            bc_star2_3;
            INTEGER num_categories := STD.Str.CountWords(bc_star2_3.categories,',');
            INTEGER name_length  := LENGTH(bc_star2_3.name);
        END;
        categories2_3 := table(bc_star2_3, layout_categories2_3);

        layout_categories4_5 := RECORD
                bc_star4_5;
                INTEGER num_categories := STD.Str.CountWords(bc_star4_5.categories,',');
                INTEGER name_length  := LENGTH(bc_star4_5.name);
        END;
        categories4_5 := table(bc_star4_5, layout_categories4_5);


    // Statistics from open and closed restaurants average of numbers of categories and name length.
    count_statistics2 := DATASET([{'star2_3', 'open and closed', AVE(categories2_3, num_categories), AVE(categories2_3, name_length)},
                            {'star4_5', 'open and closed', AVE(categories4_5, num_categories), AVE(categories4_5, name_length)},
                            {'star2_3', 'open', AVE(categories2_3(is_open), num_categories), AVE(categories2_3(is_open), name_length)},
                            {'star2_3', 'closed',  AVE(categories2_3(NOT is_open), num_categories), AVE(categories2_3(NOT is_open), name_length)},
                            {'star4_5', 'open', AVE(categories4_5(is_open), num_categories), AVE(categories4_5(is_open), name_length)},
                            {'star4_5', 'closed',  AVE(categories4_5(NOT is_open), num_categories), AVE(categories4_5(NOT is_open), name_length)}],
                            {STRING15 range_stars, STRING status, INTEGER avg_categories, INTEGER avg_name_length});
    OUTPUT(count_statistics2, NAMED('basic_statistics_2s'));



// for answering the third question

/*
Some factors besides the quality of the food and the location of the establishment can indicate the success or failure of the enterprise. For this, we will analyze some factors of the business and verify if there is any correlation with the average evaluation attributes above 3.5 stars with acceptance of credit card or if it haave delivery.

For this, we must be able to access the data in the attribute hierarchy in the database. We will transform the status into a column in which we will be able to correlate with the well-evaluated establishments.

*/

// replace the " for blank. 
layout_inferences_categories := RECORD
    business_category;
    categories_ := STD.Str.FindReplace(business_category.attributes, '"' , '');
END;
table_categories := TABLE(business_category, layout_inferences_categories);


// new layout for the new dataset
layout_inferences := RECORD
    table_categories;
    BOOLEAN is_it_good := table_categories.stars >= 3.5;
    BOOLEAN has_delivery := STD.Str.FindWord(table_categories.categories_, 'RestaurantsDelivery:True');
    BOOLEAN accept_credit_cards := STD.Str.FindWord(table_categories.categories_, 'BusinessAcceptsCreditCards:True');  
END;

ds_inferences := TABLE(table_categories, layout_inferences);
OUTPUT(ds_inferences, NAMED('table_inferences'));


// Correlation between is_it_good with has_delivery and is_it_good with accept_credit_cards
corr_delivery := CORRELATION(ds_inferences, (INTEGER) is_it_good, (INTEGER) has_delivery);
corr_credit_cards := CORRELATION(ds_inferences, (INTEGER) is_it_good, (INTEGER) accept_credit_cards);

corr_table := DATASET([{'3.5 stars or more with has delivery', corr_delivery},
                       {'3.5 stars or more with accept credit cards', corr_credit_cards}],
                       {STRING correlation_between, REAL value_correlation});
OUTPUT(corr_table, NAMED('correlation'));

