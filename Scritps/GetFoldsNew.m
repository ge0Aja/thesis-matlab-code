function [ Data ] = GetFoldsNew( FinalStats )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here
    FlowsStats =[];
for i=1:length(FinalStats)
 if(~isempty(FinalStats{i}))
    FlowsStats = vertcat(FlowsStats,FinalStats{i});

    shuffledFlowsStats = FlowsStats(randperm(size(FlowsStats,1)),:);
    Label = shuffledFlowsStats(:,end);
    shuffledFlowsStats(:,end) = [];
    Ind = crossvalind('Kfold',length(shuffledFlowsStats),10);
 end
end
 for j=1:5
        testInd = (Ind == j);
        trainInd = ~testInd;
        trainLabel = Label(trainInd);
        testLabel = Label(testInd);
        
        trainData =  shuffledFlowsStats(trainInd,:);
        testData =  shuffledFlowsStats(testInd,:); 
        
        Data{j}{1} = trainData;
        Data{j}{2} = trainLabel;
        Data{j}{3} = testData;
        Data{j}{4} = testLabel;
 end
end     

