function [ finalacc ] = parQuadSVM( Traindata,polydegree,boxconst,indic,itr,Useriter)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
parfor i=1:3
    testind = (indic == i);
    trainind = ~testind;
    QuadSvm =  trainSVMQuad(Traindata(trainind,:),polydegree,boxconst);
     pred = predict(QuadSvm.ClassificationSVM,Traindata(testind,1:28));
    acc(i)=100*sum(pred==Traindata(testind,end))/length(pred);
    fprintf('finished for Quad in Fold %d for local iteration %d for User %d\n',i,itr,Useriter);
end
finalacc = mean(acc);
end

