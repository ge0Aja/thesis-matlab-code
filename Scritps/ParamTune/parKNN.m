function [ finalacc ] = parKNN( Traindata,subspaceDimension,learnersnum,indic,itr,Useriter)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
parfor i=1:3
testind = (indic == i);
    trainind = ~testind;
    KnnSub =  trainClassifierKNN(Traindata(trainind,:),subspaceDimension,learnersnum);
    pred = predict(KnnSub.ClassificationEnsemble,Traindata(testind,1:28));
    acc(i)=100*sum(pred==Traindata(testind,end))/length(pred);
     fprintf('finished for KNN in Fold %d for local iteration %d for User %d\n',i,itr,Useriter);
end
 finalacc = mean(acc);
end

