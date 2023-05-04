// W20230215-142441
IMPORT $;

slice := RECORD
    $.Dataset_User.File.user_id;
    $.Dataset_user.File.name;
    $.Dataset_User.File.useful;
    $.Dataset_User.File.funny;
    $.Dataset_User.File.fans;
    BOOLEAN is_useful  := $.Dataset_User.File.useful > 0;
    BOOLEAN is_funny   := $.Dataset_User.File.funny > 0;
    BOOLEAN useful_or_funny  := $.Dataset_User.File.useful > 0 OR $.Dataset_User.File.funny > 0;
END;

sliced_table := TABLE($.Dataset_User.File, slice);

fans_useful := CORRELATION(sliced_table, fans, useful);
fans_funny  := CORRELATION(sliced_table, fans, funny);

Corr_table := DATASET([{'fans_useful', fans_useful},
                       {'fans_funny', fans_funny}],
                       {STRING15 Correlation_Between, DECIMAL Correlation});
                

OUTPUT(sliced_table, NAMED('Table'));
OUTPUT(Corr_table, NAMED('Correlation'));

top10users := SORT(sliced_table, -fans);

OUTPUT(top10users[..10],NAMED('top10users'));

// counting the numbers of registers that useful_or_funny = TRUE
// cnt_useful_funny := top10users(useful_or_funny);

// All the 100 first rows get a TRUE Value
// pct := (cnt_useful_funny *100) / 10;
// OUTPUT(pct,NAMED('Pct_useful_funny_in_top10users'));
