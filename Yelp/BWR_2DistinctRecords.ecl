// W20230214-115321

IMPORT $;

// Sorting, dedup and count for Business Dataset and bussiness_id :
SortBusiness_busid  := SORT($.Dataset_Business.File, business_id);
DedupBusiness_busid := DEDUP(SortBusiness_busid,
                       LEFT.business_id = RIGHT.business_id);
                      // :PERSIST('~yelp::PERSIST::Business::Dedup_busid');
DistBusiness_busid  := COUNT(DedupBusiness_busid);   

// Sorting, dedup and count for Checkin Dataset and bussiness_id :
SortCheckin_busid  := SORT($.Dataset_Checkin.File, business_id);
DedupCheckin_busid := DEDUP(SortCheckin_busid,
                      LEFT.business_id = RIGHT.business_id); 
                     //  :PERSIST('~yelp::PERSIST::Checkin::Dedup_busid');
DistCheckin_busid  := COUNT(DedupCheckin_busid);                    

// Sorting, dedup and count for Review Dataset and review_id :
SortReview_revid  := SORT($.Dataset_Review.File, review_id);
DedupReview_revid := DEDUP(SortReview_revid,
                      LEFT.review_id = RIGHT.review_id); 
                     //  :PERSIST('~yelp::PERSIST::Review::Dedup_revid');
DistReview_revid  := COUNT(DedupReview_revid);

// Sorting, dedup and count for Review Dataset and bussiness_id :
SortReview_busid  := SORT($.Dataset_Review.File, business_id);
DedupReview_busid := DEDUP(SortReview_busid,
                      LEFT.business_id = RIGHT.business_id); 
                     //  :PERSIST('~yelp::PERSIST::Review::Dedup_busid');
DistReview_busid  := COUNT(DedupReview_busid);

// Sorting, dedup and count for Review Dataset and user_id :
SortReview_useid  := SORT($.Dataset_Review.File, user_id);
DedupReview_useid := DEDUP(SortReview_useid,
                      LEFT.user_id = RIGHT.user_id); 
                     //  :PERSIST('~yelp::PERSIST::Review::Dedup_useid');
DistReview_useid  := COUNT(DedupReview_useid);

// Sorting, dedup and count for Tip Dataset and business_id :
SortTip_busid  := SORT($.Dataset_Tip.File, business_id);
DedupTip_busid := DEDUP(SortTip_busid,
                      LEFT.business_id = RIGHT.business_id); 
                     //  :PERSIST('~yelp::PERSIST::Tip::Dedup_busid');
DistTip_busid  := COUNT(DedupTip_busid);

// Sorting, dedup and count for Tip Dataset and user_id :
SortTip_useid  := SORT($.Dataset_Tip.File, user_id);
DedupTip_useid := DEDUP(SortTip_useid,
                      LEFT.user_id = RIGHT.user_id); 
                     //  :PERSIST('~yelp::PERSIST::Tip::Dedup_useid');
DistTip_useid  := COUNT(DedupTip_useid);

// Sorting, dedup and count for User Dataset and user_id :
SortUser_useid  := SORT($.Dataset_User.File, user_id);
DedupUser_useid := DEDUP(SortUser_useid,
                      LEFT.user_id = RIGHT.user_id); 
                     //  :PERSIST('~yelp::PERSIST::User::Dedup_useid');
DistUser_useid  := COUNT(DedupUser_useid);

// Making the table for the output
Dist_Records_Dataset := DATASET([{'Business', 'business_id', DistBusiness_busid},
                                {'Checkin',  'business_id', DistCheckin_busid},
                                {'Review',   'review_id',   DistReview_revid},
                                {'Review',   'business_id', DistReview_busid},
                                {'Review',   'user_id',     DistReview_useid},
                                {'Tip',      'business_id', DistTip_busid},
                                {'Tip',      'user_id',     DistTip_useid},
                                {'User',     'user_id',     DistUser_useid}],
                                {STRING15 Table, STRING15 Key, INTEGER distinct_records});


OUTPUT(Dist_Records_Dataset,, NAMED('DistinctRecords'));