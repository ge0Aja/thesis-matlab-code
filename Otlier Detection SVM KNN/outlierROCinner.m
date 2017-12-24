function [ FPR,TPR ] = outlierROCinner( testpoints,snappoints,t)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
count = 1;
for i = 5000:-0.5:1
    FP(count) = sum(testpoints{t} >= i);
%     FP1(count) = sum(finaloutlier2new >= i) ;
    TP(count) = sum(snappoints{t} >= i) ;
    
    TN(count) =  sum(testpoints{t} <i);
%     TP1(count) = sum(finaloutlier2new < i);
    FN(count) = sum(snappoints{t} < i);
    
    FPR(count) = (FP(count)) ./ (FP(count) + TN(count)); %FP1(count)
    TPR(count) = (TP(count)) ./ (TP(count) + FN(count)); %TP1(count)
count = count +1;
end

end

