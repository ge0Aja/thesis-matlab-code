function [ PartRes ] = parSVMQuadtest( DataSet,polyorder,Quadbox,i)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
parfor j = 1: length(polyorder)
    QuadSvmcl =  trainSVMQuad(DataSet{1},polyorder(j),Quadbox(j));
     predQuad = predict(QuadSvmcl.ClassificationSVM,DataSet{2}(:,1:28));
    accQuad(j)=100*sum(predQuad==DataSet{2}(:,end))/length(predQuad);
     Quadconf = confusionmat(DataSet{2}(:,end),predQuad);
    [QuadTPR(j,:),QuadFPR(j,:),QuadF1(j,:)] = CalcTRPFPR(Quadconf);
      fprintf('finished for Quad For Settings %d for Dataset %d\n',j,i);
end

PartRes{1} = accQuad;
PartRes{2} = QuadTPR;
PartRes{3} = QuadFPR;
PartRes{4} = QuadF1;
end

