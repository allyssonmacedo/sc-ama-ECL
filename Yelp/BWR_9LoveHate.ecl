// W20230215-190942
IMPORT $;

layout := RECORD
    $.Dataset_Review.File.review_id;
    $.Dataset_Review.File.business_id;
    $.Dataset_Review.File.stars;
    $.Dataset_Review.File.text;
END;

text_records := TABLE($.Dataset_Review.File, layout);

love := [' love ', ' love.', ' love,', ' love!,', ' love?', '#love'];
hate := [' hate ', ' hate.', ' hate,', ' hate!,', ' hate?', '#hate'];

RULE has_love := love;
RULE has_hate :=  hate;

love_ds := RECORD
          text_records.review_id;
          text_records.business_id;
          text_records.stars;
          STRING love_col := MATCHTEXT(has_love);
END;

hate_ds := RECORD
          text_records.review_id;
          text_records.business_id;
          text_records.stars;
          STRING hate_col := MATCHTEXT(has_hate);
END;

parse_love := PARSE(text_records, text, has_love, love_ds, BEST, NOCASE);
parse_hate := PARSE(text_records, text, has_hate, hate_ds, BEST, NOCASE);

OUTPUT(parse_love, NAMED('love_table'));
OUTPUT(parse_hate, NAMED('hate_table'));

love_count := count(parse_love);
hate_count := count(parse_hate);

love_hate := DATASET([{'love', COUNT(parse_love)},
                      {'hate', COUNT(parse_hate)}],
                      {STRING15 review, UNSIGNED4 cnt_reviews}):PERSIST('~yelp::PERSIST::love_hate_count');
                         
OUTPUT(love_hate, NAMED('love_hate_count'));


// with the review_id or business_id it is possible to join the tables and get the business best ranked or if the hate and love words are related with the average of stars.

// love(7.627.44) x hate (57.049)




