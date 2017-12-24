function [ Fin ] = FiveFoldsNewData21March( data )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

Ind = crossvalind('Kfold',length(data),5);
Label = data(:,end);
%data(:,end) = [];
 
  for j=1:5
        testInd = (Ind == j);
        trainInd = ~testInd;
        %trainLabel = Label(trainInd);
        testLabel = Label(testInd);
      
        trainData =  data(trainInd,:);
        testData = data(testInd,:);
        testData =  data(testInd,[false false false true true false false false false false false true false false false true false false false false false false false true false false false false false]); 
        %testData(:,end) = []; 

        [trainedClassifier, resubstitutionAccuracy] = trainClassifierBaggedTree5Featver2(trainData); %trainClassifierBaggedTree(trainData);
        
        res = trainedClassifier.predict(testData);
        
        ConfusionMatrix = CalcConf(res,testLabel);  
        [TPR,FPR,TP,FP,FN,TN] = CalcTRPFPR(ConfusionMatrix);
        
     Fin{j,1} = TPR;
     Fin{j,2} = FPR;
     Fin{j,3} = TP;
     Fin{j,4} = FP;
     Fin{j,5} = FN;
     Fin{j,6} = TN;
     Fin{j,7} = ConfusionMatrix;
  end
 
end

