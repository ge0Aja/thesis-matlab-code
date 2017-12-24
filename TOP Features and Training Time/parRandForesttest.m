function [ PartRes ] = parRandForesttest( DataSet,Forestlearner,ForestPredict,Forestleaf,i)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
parfor j =1:length(Forestlearner)
 RandForestcl =  trainRandomForest(DataSet{1},Forestlearner(j),ForestPredict(j),Forestleaf(j));
    prdRandForest = predict(RandForestcl,DataSet{2}(:,1:28));
    mat = cell2mat(prdRandForest);
    as = str2num(mat);
    Forestconf = confusionmat(DataSet{2}(:,end),as);
    [ForestTPR(j,:),ForestFPR(j,:),ForestF1(j,:)] = CalcTRPFPR(Forestconf);
    accRandomForest(j)=100*sum(as==DataSet{2}(:,end))/length(as);
    fprintf('finished for RandomForest For Settings %d for Dataset %d\n',j,i);
end
PartRes{1} = accRandomForest;
PartRes{2} = ForestTPR;
PartRes{3} = ForestFPR;
PartRes{4} = ForestF1;
end

