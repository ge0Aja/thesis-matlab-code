function [ TempTPR,TempFPR,TempF1] = CalcTRPFPR( ConfusionMatrix )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%,TempTP,TempFP,TempFN,TempTN 
        for i=1:length(ConfusionMatrix)
            TempTP(i) = ConfusionMatrix(i,i);
            TempFP(i) = sum(ConfusionMatrix(:,i)) - ConfusionMatrix(i,i);
            TempFN(i) = sum(ConfusionMatrix(i,:)) - ConfusionMatrix(i,i);
            TempTN(i) = sum(ConfusionMatrix(:)) - TempTP(i) - TempFP(i) - TempFN(i);
            
            TempTPR(i) = TempTP(i) ./ (TempTP(i) + TempFN(i));
            TempFPR(i) = TempFP(i) ./ (TempFP(i) + TempTN(i));
            TempF1(i) = 2 * TempTP(i) ./ (2 * TempTP(i) + (TempFP(i) + TempFN(i)));
        end
        
        TPR(i) = mean(TempTPR);
        FPR(i) = mean(TempFPR);
        % 2*TP /(2*TP + FP + FN) 
        
%         TempTN = TempTN';
%         TempFN = TempFN';
%         TempFP = TempFP';
%         TempTP = TempTP';
        FPR = FPR';
        TPR = TPR';
end

