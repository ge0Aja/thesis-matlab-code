function [ GausSVMResults,QuadSVMResults,RandForestResults,BaggedResults,KNNResults] = Tuneparams( Traindata,N,Useriter )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
polydegree = [1 2 3 4 5 6];
kernelscale = 0.1:0.2:6;
alpha = 0.1:0.1:2;
boxconst = 0.1:0.2:2;
learners = 200:-25:25;
predictors = 27:-1:5;
leafsize = [6 5 4 3 2];

polydegreesize = numel(polydegree);
kernelscalesize = numel(kernelscale);
alphasize = numel(alpha);
boxconstsize = numel(boxconst);
learnerssize = numel(learners);
predictorssize = numel(predictors);
leafsizesize = numel(leafsize);


KNNResults = [];
BaggedResults = [];
RandForestResults = [];
QuadSVMResults = [];
GausSVMResults = [];


indic =  crossvalind('Kfold',length(Traindata),3);

parfor i=1:N
    kernelscaleG = kernelscale(randperm(kernelscalesize, 1));
    boxconstG = boxconst(randperm(boxconstsize, 1));
%      alphaG =  alpha(randperm(alphasize, 1));
   GausSVMacc(i) =  parGausSVM( Traindata,kernelscaleG,boxconstG,indic,i,Useriter);
   GausSVMResults(i) = [GausSVMacc(i) kernelscaleG boxconstG alphaG];
end
fprintf('finished for Gussian for User %d\n',Useriter);

parfor i=1:N
    polydegrQ = polydegree(randperm(polydegreesize, 1));
    boxconstQ = boxconst(randperm(boxconstsize, 1));
%     alphaQ =  alpha(randperm(alphasize, 1));
    QuadSVMacc(i) = parQuadSVM( Traindata,polydegrQ,boxconstQ,indic,i,Useriter);
    QuadSVMResults(i) = [QuadSVMacc(i) polydegrQ boxconstQ];
end
fprintf('finished for Quadratic for User %d\n',Useriter);

parfor i=1:N
    learnForest = learners(randperm(learnerssize, 1));
    predForest = predictors(randperm(predictorssize, 1));
    leafForest = leafsize(randperm(leafsizesize, 1));
    accRandForest(i)= parRandForest( Traindata,learnForest,predForest,leafForest,indic,i,Useriter );
    RandForestResults(i) = [accRandForest(i) learnForest predForest leafForest];
end
fprintf('finished for Random Forest for User %d\n',Useriter);

parfor i=1:length(learners)
 learnBagg = learners(i);
 accbagg(i)  = parbagg(Traindata,learnBagg,indic);
 BaggedResults(i) = [accbagg(i) learnBagg] ;
end
fprintf('finished for Bagged for User %d\n',Useriter);

parfor i=1:N
    predKNN = predictors(randperm(predictorssize, 1));
    learnKNN = learners(randperm(learnerssize, 1));
    accKNN(i) = parKNN( Traindata,predKNN,learnKNN,indic);
    KNNResults(i) = [accKNN(i) predKNN learnKNN] ;
end
fprintf('finished for KNN for User %d\n',Useriter);
end