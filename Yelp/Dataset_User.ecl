EXPORT Dataset_User := MODULE
  EXPORT Layout := RECORD
    STRING22 user_id {XPATH('user_id')};
    STRING name {XPATH('name')};  
    UNSIGNED3 review_count {XPATH('review_count')};
    STRING10 yelping_since {XPATH('yelping_since')};
    STRING friends {XPATH('friends')};
    UNSIGNED3 useful {XPATH('useful')};
    UNSIGNED3 funny {XPATH('funny')};
    UNSIGNED3 cool {XPATH('cool')};
    UNSIGNED3 fans {XPATH('fans')};
    STRING elite {XPATH('elite')};
    DECIMAL2_1 average_stars {XPATH('average_stars')};
    UNSIGNED3 compliment_hot {XPATH('compliment_hot')};
    UNSIGNED3 compliment_more {XPATH('compliment_more')};
    UNSIGNED3 compliment_profile {XPATH('compliment_profile')};
    UNSIGNED3 compliment_cute {XPATH('compliment_cute')};
    UNSIGNED3 compliment_list {XPATH('compliment_list')};
    UNSIGNED3 compliment_note {XPATH('compliment_note')};
    UNSIGNED3 compliment_plain {XPATH('compliment_plain')};
    UNSIGNED3 compliment_cool {XPATH('compliment_cool')};
    UNSIGNED3 compliment_funny {XPATH('compliment_funny')};
    UNSIGNED3 compliment_writer {XPATH('compliment_writer')};
    UNSIGNED3 compliment_photos {XPATH('compliment_photos')};
  END;
  
  EXPORT File := DATASET('~yelp::dataset::user.json', Layout, JSON('', NOROOT));

  EXPORT Sample := SAMPLE(File, 100);

END;