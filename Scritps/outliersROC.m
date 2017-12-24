for t = 1 : 6
[ FPR(t,:),TPR(t,:)] = outlierROCinner(testpoints,snappoints,t);
figure
plot(FPR(t,:),TPR(t,:));
end



AllAppsSnapOutlier = [];
AllAppsTestOutlier = [];
for i = 1:6
    AllAppsSnapOutlier = horzcat(AllAppsSnapOutlier,snappoints{i});
    AllAppsTestOutlier = horzcat(AllAppsTestOutlier,testpoints{i});
end

OverallSnapOutlier = mean(AllAppsSnapOutlier,2);
OverallTestOutlier = mean(AllAppsTestOutlier,2);


count = 1;
for i = 5000:-0.5:1
    FP(count) = sum(OverallTestOutlier >= i);
%     FP1(count) = sum(finaloutlier2new >= i) ;
    TP(count) = sum(OverallSnapOutlier >= i) ;
    
    TN(count) =  sum(OverallTestOutlier <i);
%     TP1(count) = sum(finaloutlier2new < i);
    FN(count) = sum(OverallSnapOutlier < i);
    
    FPR(count) = (FP(count)) ./ (FP(count) + TN(count)); %FP1(count)
    TPR(count) = (TP(count)) ./ (TP(count) + FN(count)); %TP1(count)
count = count +1;
end
