figure

subplot(2,3,6,'replace')
[AYoutubeoutier,BinYoutubeoutier] = ksdensity(Youtubeprd);
[AYoutubesnap,BinYoutubesnap]= ksdensity(Youtubesnap);
hold on
plot(BinYoutubeoutier,AYoutubeoutier,'--k','LineWidth',2);
plot(BinYoutubesnap,AYoutubesnap,'-.k','LineWidth',2);
title('Youtube/ Snapchat Outlier Score Distribution')
legend('Youtube','Snapchat')


count = 1;
for i = max(Youtubeprd):-0.05:min(Youtubeprd)
    FPYoutube(count) = sum(Youtubeprd >= i);
%     FP1(count) = sum(finaloutlier2new >= i) ;
    TPYoutube(count) = sum(Youtubesnap >= i) ;
    
    TNYoutube(count) =  sum(Youtubeprd <i);
%     TP1(count) = sum(finaloutlier2new < i);
    FNYoutube(count) = sum(Youtubesnap < i);
    
    FPRYoutube(count) = (FPYoutube(count)) ./ (FPYoutube(count) + TNYoutube(count)); %FP1(count)
    TPRYoutube(count) = (TPYoutube(count)) ./ (TPYoutube(count) + FNYoutube(count)); %TP1(count)
count = count +1;
end


figure
c ={'Youtube','8 Ball Pool','Youtube','Youtube','Youtube','Youtube'};

subplot(2,3,6,'replace')
plot(FPRYoutube,TPRYoutube,'-k','Linewidth',2)
title(strcat('ROC ',c{6}, '/ Snap Outlier detection'))
xlabel('FPR')
ylabel('TPR')


