// W20230216-155409

IMPORT $;

Layout := RECORD
  $.Dataset_User.File.user_id;
  $.Dataset_User.File.name;
  $.Dataset_User.File.review_count;
END;

Tbl := TABLE($.Dataset_User.File, Layout);
TopUsers := SORT(Tbl, -review_count);

OUTPUT(TopUsers[..3],,NAMED('Top3Users'));