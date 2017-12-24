function [ Fin ] = AllTrainAllTest( AllFolds )
%UNTITLED17 Summary of this function goes here
%   Detailed explanation goes here
for j=1:5  
    TrainSet = [];
    TrainLabel = [];
    TestSet = [];
    TestLabel = [];
    
    for i=1:9
        TrainSet = vertcat(TrainSet,AllFolds{i}{j}{1});
        TrainLabel = vertcat(TrainLabel,AllFolds{i}{j}{2});
        TestSet = vertcat(TestSet,AllFolds{i}{j}{3});
        TestLabel = vertcat(TestLabel,AllFolds{i}{j}{4});
    end
        trainedClassifier = fitensemble(TrainSet, TrainLabel, 'Bag', 200, 'Tree', 'Type', 'Classification', 'ClassNames', [1 2 3 4 5 6]);
        %trainedClassifier = fitctree(TrainSet, TrainLabel, 'PredictorNames', {'column_1' 'column_2' 'column_3' 'column_4' 'column_5' 'column_6' 'column_7' 'column_8' 'column_9' 'column_10' 'column_11' 'column_12' 'column_13' 'column_14' 'column_15' 'column_16' 'column_17' 'column_18' 'column_19' 'column_20' 'column_21' 'column_22' 'column_23' 'column_24' 'column_25' 'column_26' 'column_27' 'column_28'}, 'ResponseName', 'column_29', 'ClassNames', [1 2 3 4 5 6], 'SplitCriterion', 'gdi', 'MaxNumSplits', 100, 'Surrogate', 'off');
        res = trainedClassifier.predict(TestSet);
        ConfusionMatrix = CalcConf(res,TestLabel);  
        [TPR,FPR,TP,FP,FN,TN] = CalcTRPFPR(ConfusionMatrix);
        
     Fin{j,1} = TPR;
     Fin{j,2} = FPR;
     Fin{j,3} = TP;
     Fin{j,4} = FP;
     Fin{j,5} = FN;
     Fin{j,6} = TN;
     Fin{j,7} = ConfusionMatrix;
     Fin{j,8} = trainedClassifier;
     Fin{j,9} = TrainSet;
     Fin{j,10} = TrainLabel;
     Fin{j,11} = TestSet;
     Fin{j,12} = TestLabel;
end

end

