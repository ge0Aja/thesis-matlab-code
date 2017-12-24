function [ PartRes ] = parKnntest( DataSet,KnnPredict,Knnlearner,neighborKNN,i)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
parfor j = 1:length(KnnPredict)
KnnSubcl =  trainClassifierKNN(DataSet{1},KnnPredict(j),Knnlearner(j),1);
     predKnn = predict(KnnSubcl.ClassificationEnsemble,DataSet{2}(:,1:28));
    accknnSub(j)=100*sum(predKnn==DataSet{2}(:,end))/length(predKnn);
     KNNconf = confusionmat(DataSet{2}(:,end),predKnn);
    [KNNTPR(j,:),KNNFPR(j,:),KNNF1(j,:)] = CalcTRPFPR(KNNconf);
   fprintf('finished for KNN For Settings %d for Dataset %d\n',j,i);
end
PartRes{1} = accknnSub;
PartRes{2} = KNNTPR;
PartRes{3} = KNNFPR;
PartRes{4} = KNNF1;
end

