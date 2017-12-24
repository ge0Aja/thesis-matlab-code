function [ finalacc ] = parRandForest( Traindata,learnForest,predForest,leafForest,indic,itr,Useriter )
%UNTITLED8 Summary of this function goes here
%   Detailed explanation goes here
parfor i=1:3
    testind = (indic == i);
    trainind = ~testind;
    RandForest =  trainRandomForest(Traindata(trainind,:),learnForest,predForest,leafForest);
    prd = predict(RandForest,Traindata(testind,1:28));
    mat = cell2mat(prd);
    as = str2num(mat);
    acc(i)=100*sum(as==Traindata(testind,end))/length(as);
        fprintf('finished for Random Forest in Fold %d for local iteration %d for User %d\n',i,itr,Useriter);
end
finalacc = mean(acc);
end

