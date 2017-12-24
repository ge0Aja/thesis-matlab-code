function [ finalacc ] = parGausSVM( Traindata,kernelscale,boxconst,indic,itr,Useriter)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here
parfor i=1:3
    testind = (indic == i);
    trainind = ~testind;
    GaussianSvm =  trainSVMGuas(Traindata(trainind,:),kernelscale,boxconst);
    pred = predict(GaussianSvm.ClassificationSVM,Traindata(testind,1:28));
    acc(i)=100*sum(pred==Traindata(testind,end))/length(pred);
    fprintf('finished for Gaussian in Fold %d for local iteration %d for User %d\n',i,itr,Useriter);
end
finalacc = mean(acc);
end

