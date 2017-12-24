counters = [];
for i = 1 : length(All5)

  facebookind = sum((All5{i}(:,end) == 1));
  gameind  = sum((All5{i}(:,end) == 2));
  skypeind  = sum((All5{i}(:,end) == 3));
  viberind = sum((All5{i}(:,end) == 4));
  whatsappind = sum((All5{i}(:,end) == 5));
  youtubeind = sum((All5{i}(:,end) == 6));
  counters = vertcat(counters,[facebookind gameind skypeind viberind whatsappind youtubeind]);
    
end