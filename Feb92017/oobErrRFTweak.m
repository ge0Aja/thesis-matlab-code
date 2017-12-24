function [Err,FPR] = oobErrRFTweak(params,X,X2)
%oobErrRF Trains random forest and estimates out-of-bag quantile error
%   oobErr trains a random forest of 300 regression trees using the
%   predictor data in X and the parameter specification in params, and then
%   returns the out-of-bag quantile error based on the median. X is a table
%   and params is an array of OptimizableVariable objects corresponding to
%   the minimum leaf size and number of predictors to sample at each node.
options = statset('UseParallel',1);
%,'options',options

% [tr_b,te_b] = getTrain_Test(browsing,1,[1]);
% [tr_g,te_g] = getTrain_Test(gaming,2,[2]);
% 
% X(X(:,32) == 1 | X(:,32) == 2,:) = [];
% X2(X2(:,32) == 1 | X2(:,32) == 2,:) = [];
% 
% X = vertcat(X,vertcat(tr_b,tr_g));
% X2 = vertcat(X2,vertcat(te_b,te_g));

randomForest = TreeBagger(30,X(:,1:28),X(:,32),'Method','classification',...
    'OOBPrediction','on','MinLeafSize',params.minLS,...
    'NumPredictorstoSample',params.Predictors,'options',options);
% oobErr = oobQuantileError(randomForest);

prdRandForest = predict(randomForest,X2(:,1:28));
as=cellfun(@str2num,prdRandForest); 
Forestconf = confusionmat(X2(:,32),as);
[ForestTPR,ForestFPR,ForestF1] = CalcTRPFPR(Forestconf);

Err = 1 - mean(ForestF1);
FPR = mean(ForestFPR) - 0.05;
end