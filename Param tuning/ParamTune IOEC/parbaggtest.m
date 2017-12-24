function [ PartRes ] = parbaggtest( DataSet,Bagglearner,i)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
parfor j = 1 : length(Bagglearner)
    baggedcl = trainClassifierBaggedTreesComplete(DataSet{1},Bagglearner(j));
    predbagg = predict(baggedcl,DataSet{2}(:,1:28));
    accbagg(j)=100*sum(predbagg==DataSet{2}(:,end))/length(predbagg);
    baggedconf = confusionmat(DataSet{2}(:,end),predbagg);
    [baggedTPR(j,:),baggedFPR(j,:),baggedF1(j,:)] = CalcTRPFPR(baggedconf);
    
  fprintf('finished for bagegd For Settings %d for Dataset %d\n',j,i);
end
PartRes{1} = accbagg;
PartRes{2} = baggedTPR;
PartRes{3} = baggedFPR;
PartRes{4} = baggedF1;
end

