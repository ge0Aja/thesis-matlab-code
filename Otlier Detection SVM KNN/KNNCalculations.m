youtubetest = [];
youtubesnap = [];

youtubetest = [];
youtubesnap = [];

youtubetest = [];
youtubesnap = [];

youtubetest = [];
youtubesnap = [];

youtubetest = [];
youtubesnap = [];

youtubetest = [];
youtubesnap = [];

        for i =1:9
            try
            youtubetest = vertcat(youtubetest,Dist{i}{1}{2});
            youtubesnap = vertcat(youtubesnap,Dist{i}{1}{4});
            catch
            end
            
            youtubetest = vertcat(youtubetest,Dist{i}{2}{2});
            youtubesnap = vertcat(youtubesnap,Dist{i}{2}{4});
            
            
            youtubetest = vertcat(youtubetest,Dist{i}{3}{2});
            youtubesnap = vertcat(youtubesnap,Dist{i}{3}{4});
            
            youtubetest = vertcat(youtubetest,Dist{i}{4}{2});
            youtubesnap = vertcat(youtubesnap,Dist{i}{4}{4});
            
            youtubetest = vertcat(youtubetest,Dist{i}{5}{2});
            youtubesnap = vertcat(youtubesnap,Dist{i}{5}{4});
            
            youtubetest = vertcat(youtubetest,Dist{i}{6}{2});
            youtubesnap = vertcat(youtubesnap,Dist{i}{6}{4});
            
        end
        
youtubetestS = mean(youtubetest,2) ./ max(mean(youtubetest,2));
youtubesnapS = mean(youtubesnap,2) ./ max(mean(youtubetest,2));
subplot(2,3,6,'replace')
[Ayoutubeoutier,Binyoutubeoutier] = ksdensity(youtubetestS);
[Ayoutubesnap,Binyoutubesnap]= ksdensity(youtubesnapS);
hold on
plot(Binyoutubeoutier,Ayoutubeoutier,'--k','LineWidth',2);
plot(Binyoutubesnap,Ayoutubesnap,'-.k','LineWidth',2);
title('youtube / Snapchat Outlier Score Distribution')
legend('youtube','Snapchat')







count = 1;
for i = max(youtubesnapS):-0.005:0
    FPyoutube(count) = sum(youtubetestS >= i);
%     FP1(count) = sum(finaloutlier2new >= i) ;
    TPyoutube(count) = sum(youtubesnapS >= i) ;
    
    TNyoutube(count) =  sum(youtubetestS <i);
%     TP1(count) = sum(finaloutlier2new < i);
    FNyoutube(count) = sum(youtubesnapS < i);
    
    FPRyoutube(count) = (FPyoutube(count)) ./ (FPyoutube(count) + TNyoutube(count)); %FP1(count)
    TPRyoutube(count) = (TPyoutube(count)) ./ (TPyoutube(count) + FNyoutube(count)); %TP1(count)
count = count +1;
end

subplot(2,3,6,'replace')
plot(FPRyoutube,TPRyoutube,'-ko')
title('ROC youtube / snap outlier detection')