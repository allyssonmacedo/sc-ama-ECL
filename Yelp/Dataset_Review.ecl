EXPORT Dataset_Review := MODULE
  EXPORT Layout := RECORD
    STRING22 review_id {XPATH('review_id')};
    STRING22 user_id {XPATH('user_id')};
    STRING22 business_id {XPATH('business_id')};
    INTEGER1 stars {XPATH('stars')};
    STRING10 date {XPATH('date')};
    STRING text {XPATH('text')};
    UNSIGNED3 useful {XPATH('useful')};
    UNSIGNED3 funny {XPATH('funny')};
    UNSIGNED3 cool {XPATH('cool')};
  END;
  
  EXPORT File := DATASET('~yelp::dataset::review.json', Layout, JSON('', NOROOT));

  EXPORT Sample := SAMPLE(File, 100);

END;