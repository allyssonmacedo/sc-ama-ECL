EXPORT Dataset_Checkin := MODULE
  EXPORT Layout := RECORD
    STRING22 business_id {XPATH('business_id')};   
    STRING date {XPATH('date')};
  END;
  
  EXPORT File := DATASET('~yelp::dataset::checkin.json', Layout, JSON('', NOROOT));

  EXPORT Sample := SAMPLE(File, 100);

END;