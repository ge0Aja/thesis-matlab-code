parfor i=1:9
%      parbagg( DataSets{i},200,0,0,i);
%     parQuadSVM(DataSets{i},2,1.7,0,0,i);
% parKNN( DataSets{i},5,175,3,0,0,i);
% parRandForest( DataSets{i},175,7,2,0,0,i )

% [QuadSVMacc(i) QuadSVMtpr(i,:) QuadSVMfpr(i,:) QuadSVMf1(i,:)] = parQuadSVM(DataSets{i},2,1.7,0,0,i);
%  QuadSVMResults(i,:) = [QuadSVMacc(i) polydegrQ boxconstQ QuadSVMtpr(i,: ) QuadSVMfpr(i,:) QuadSVMf1(i,:)];

%  [accKNN(i) KNNtpr(i,:) KNNfpr(i,:) KNNf1(i,:)] = parKNN( DataSets{i},10,175,3,0,0,i);
%     KNNResults(i,:) = [accKNN(i) KNNtpr(i,:) KNNfpr(i,:) KNNf1(i,:)] ;

% 
 [accRandForest(i) Foresttpr(i,:) Forestfpr(i,:) Forestf1(i,:)]= parRandForest( DataSets{i},7,175,2,0,0,i);
 RandForestResults(i,:) = [accRandForest(i) Foresttpr(i,:) Forestfpr(i,:) Forestf1(i,:)];

% 
% [accbagg(i) baggtpr(i,:) baggfpr(i,:) baggf1(i,:)]  = parbagg(DataSets{i},200,0,0,i);
%   BaggedResults(i,:) = [accbagg(i) baggtpr(i,:) baggfpr(i,:) baggf1(i,:)] ;
% %
end