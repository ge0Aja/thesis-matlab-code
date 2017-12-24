function [PartRes] = parSVMGaustest( DataSet,Gauskernel,Gausbox,i)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
parfor j = 1:length(Gauskernel)
   GaussianSvmcl =  trainSVMGuas(DataSet{1},Gauskernel(j),Gausbox(j));
    predGaus = predict(GaussianSvmcl.ClassificationSVM,DataSet{2}(:,1:28));
    accGaus(j)=100*sum(predGaus==DataSet{2}(:,end))/length(predGaus);
    Gausconf = confusionmat(DataSet{2}(:,end),predGaus);
    [GausTPR(j,:),GausFPR(j,:),GausF1(j,:)] = CalcTRPFPR(Gausconf);
     fprintf('finished for gaussian For Settings %d for Dataset %d\n',j,i);
end
PartRes{1} = accGaus;
PartRes{2} = GausTPR;
PartRes{3} = GausFPR;
PartRes{4} = GausF1;
end

