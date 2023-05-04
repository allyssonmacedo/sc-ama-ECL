EXPORT Dataset_Tip := MODULE
  EXPORT Layout := RECORD
    STRING text {XPATH('text')};
    STRING10 date {XPATH('date')};
    UNSIGNED3 compliment_count {XPATH('compliment_count')};
    STRING22 business_id {XPATH('business_id')};   
    STRING22 user_id {XPATH('user_id')};
  END;
  
  EXPORT File := DATASET('~yelp::dataset::tip.json', Layout, JSON('', NOROOT));

  EXPORT Sample := SAMPLE(File, 100);

END;