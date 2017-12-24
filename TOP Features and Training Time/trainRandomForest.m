function [ b ] = trainRandomForest( traindata,treesnum,numpredtosample,mnleafsize )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% for OOB [true false true true false true false false true true false false false false false false false true true true true true true true false true false false false]

op = statset('UseParallel',true);
    b = TreeBagger(treesnum,traindata(:,[false false false true true false false false false false true true true true false true true true false true false true false true true true false false false]),traindata(:,end),'Method','classification','OOBVarImp','On',...
    'NumPredictorsToSample',numpredtosample,...
    'MinLeafSize',mnleafsize,...
'OOBPrediction','on',...
'Options',op);

end

