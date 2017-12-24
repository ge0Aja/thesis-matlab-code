function [ finalacc ] = parbagg( Traindata,numlearners,indic,itr,Useriter)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
parfor i=1:3
    testind = (indic == i);
    trainind = ~testind;
    Bagged =  trainClassifierBaggedTreesComplete(Traindata(trainind,:),numlearners);
    pred = predict(Bagged,Traindata(testind,1:28));
    acc(i)=100*sum(pred==Traindata(testind,end))/length(pred);
     fprintf('finished for Bagged in Fold %d for local iteration %d for User %d\n',i,itr,Useriter);
end
    finalacc = mean(acc);
end

