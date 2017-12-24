for t = 1 : 6
[ FPRYoutube(t,:),TPRYoutube(t,:)] = outlierROCinner(testpoints,snappoints,t);
figure
plot(FPRYoutube(t,:),TPRYoutube(t,:));
end



AllAppsSnapOutlier = [];
AllAppsTestOutlier = [];
for i = 1:6
    AllAppsSnapOutlier = horzcat(AllAppsSnapOutlier,snappoints{i});
    AllAppsTestOutlier = horzcat(AllAppsTestOutlier,testpoints{i});
end

OverallSnapOutlier = mean(AllAppsSnapOutlier,2);
OverallTestOutlier = mean(AllAppsTestOutlier,2);

figure

% 
% FP = [];
% TP = [];
% FN = [];
% TN = [];
% FPR=[];
% TPR=[];

YoutubeoutlierS  = mean(Youtubeoutlier,2) ./ max(mean(Youtubeoutlier,2));
YoutubesnapS  = mean(Youtubesnap,2) ./ max(mean(Youtubeoutlier,2));


count = 1;
%  k =1;
for i = max(YoutubesnapS):-0.005:min(YoutubeoutlierS)
    FPYoutube(count) = sum(YoutubeoutlierS >= i);
%     FP1(count) = sum(finaloutlier2new >= i) ;
    TPYoutube(count) = sum(YoutubesnapS >= i) ;
    
    TNYoutube(count) =  sum(YoutubeoutlierS <i);
%     TP1(count) = sum(finaloutlier2new < i);
    FNYoutube(count) = sum(YoutubesnapS < i);
    
    FPRYoutube(count) = (FPYoutube(count)) ./ (FPYoutube(count) + TNYoutube(count)); %FP1(count)
    TPRYoutube(count) = (TPYoutube(count)) ./ (TPYoutube(count) + FNYoutube(count)); %TP1(count)
count = count +1;
end
subplot(2,3,6,'replace')
plot(FPRYoutube(k,:),TPRYoutube(k,:),'-ko')
title('ROC Youtube / Snap outlier detection')
% 
% 
% 
% YoutubeoutlierS  = mean(Youtubeprd,2) ./ max(mean(Youtubeprd,2));
% YoutubesnapS  = mean(Youtubesnap,2) ./ max(mean(Youtubeprd,2));
% %  figure
% 
% subplot(2,3,6,'replace')
% [AYoutubeoutier,BinYoutubeoutier] = ksdensity(YoutubeoutlierS);
% [AYoutubesnap,BinYoutubesnap]= ksdensity(YoutubesnapS);
% hold on
% plot(BinYoutubeoutier,AYoutubeoutier,'--k','LineWidth',2);
% plot(BinYoutubesnap,AYoutubesnap,'-.k','LineWidth',2);
% title('Youtube / Snapchat Outlier Score Distribution')
% legend('Youtube','Snapchat')

% 
% 
