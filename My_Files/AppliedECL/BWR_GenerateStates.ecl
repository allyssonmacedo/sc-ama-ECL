IMPORT $;
State_Rec := RECORD
  STRING2   State;
  UNSIGNED1 StateCode;
 END;
States_DS :=
  DATASET([{'AE', 1},{'WY', 2},{'TN', 3},{'MI', 4},{'RI', 5},{'SC', 6},{'VA', 7},{'NH', 8},{'AP', 9},{'NM', 10}, 
           {'IL', 11},{'KS', 12}, {'ME', 13}, {'AL', 14}, {'WA', 15}, {'NY', 16}, {'MO', 17}, {'PA', 18}, {'HI', 19}, {'GU', 20}, 
           {'VT', 21},{'CT', 22}, {'NC', 23}, {'OR', 24}, {'IA', 25}, {'DE', 26}, {'VI', 27}, {'ID', 28}, {'MT', 29}, {'AR', 30}, 
           {'MS', 31},{'UT', 32}, {'NE', 33}, {'IN', 34}, {'GA', 35}, {'WV', 36}, {'NJ', 37}, {'LA', 38}, {'WI', 39}, {'AK', 40}, 
           {'CA', 41},{'NV', 42}, {'FL', 43}, {'MA', 44}, {'CO', 45}, {'AZ', 46}, {'SD', 47}, {'DC', 48}, {'KY', 49}, {'MP', 50}, 
           {'ND', 51},{'AS', 52}, {'TX', 53}, {'PR', 54}, {'MD', 55}, {'OH', 56}, {'MN', 57}, {'OK', 58}, {'AA', 59}], State_Rec);
OUTPUT(States_DS,,'~ONLINE::AppliedECL::States',OVERWRITE);
