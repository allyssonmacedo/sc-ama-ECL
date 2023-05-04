EXPORT Dataset_Business := MODULE
  EXPORT Layout := RECORD
    STRING22 business_id {XPATH('business_id')};
    VARSTRING name {XPATH('name')};
    VARSTRING address {XPATH('address')};
    VARSTRING city {XPATH('city')};
    STRING2 state {XPATH('state')};
    STRING5 postal_code {XPATH('postal_code')};
    DECIMAL latitude {XPATH('latitude')};
    DECIMAL longitude {XPATH('longitude')};
    DECIMAL2_1 stars {XPATH('stars')};
    UNSIGNED3 review_count {XPATH('review_count')};
    BOOLEAN is_open {XPATH('is_open')};
    STRING attributes {XPATH('attributes/<>')};
    STRING categories {XPATH('categories')};
    STRING hour {XPATH('hours/<>')};
    STRING11 Monday {XPATH('hours/Monday')};
    STRING11 Tuesday {XPATH('hours/Tuesday')};
    STRING11 Wednesday {XPATH('hours/Wednesday')};
    STRING11 Thursday {XPATH('hours/Thursday')};
    STRING11 Friday {XPATH('hours/Friday')};
    STRING11 Saturday {XPATH('hours/Saturday')};
    STRING11 Sunday {XPATH('hours/Sunday')};
  END;
  
  EXPORT File := DATASET('~yelp::dataset::business.json', Layout, JSON('', NOROOT));

  EXPORT Sample := SAMPLE(File, 100);
END;