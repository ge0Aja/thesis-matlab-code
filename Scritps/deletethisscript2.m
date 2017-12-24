    finalconfusion = zeros(6);
for i=1:5
    finalconfusion = finalconfusion + Fin{i,7};
end

newdata = newdata(randperm(size(newdata,1)),:);

    groupstats = [];
for i=1:6
    for j=1:length(HagopStats{i})
        groupstats = vertcat(groupstats,HagopStats{i}{j});
    end
end

shuffled = groupstats(randperm(size(groupstats,1)),:);

Label = shuffled(:,end);
testData =  shuffled(:,[true true false true true false false false false false false true false true false true false false false false true false true false true false false false]); 
 [trainedClassifier, resubstitutionAccuracy] = trainClassifierBaggedTree(newdata); %trainClassifierBaggedTree(trainData);
        
        res = trainedClassifier.predict(testData);
        
        ConfusionMatrix = CalcConf(res,Label);  
        [TPR,FPR,TP,FP,FN,TN] = CalcTRPFPR(ConfusionMatrix);
        
     Fin{j,1} = TPR;
     Fin{j,2} = FPR;
     Fin{j,3} = TP;
     Fin{j,4} = FP;
     Fin{j,5} = FN;
     Fin{j,6} = TN;
     Fin{j,7} = ConfusionMatrix;