function [Fin3] = FoldUser( DataSets,bagged)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
parfor j = 1:30    
 [testAppsInd,testmin,trainzeros]  = FindAppsInd(DataSets{2});
   balancedtest = [];
   for k=1:6
        TempMatrTest = DataSets{2}(testAppsInd{k},:);
        c1 = randperm(length(TempMatrTest),testmin);
        balancedtest = vertcat(balancedtest,TempMatrTest(c1,:)); 
   end
   predbagged = predict(bagged,balancedtest(:,1:28));
   baggedconf = confusionmat(balancedtest(:,end),predbagged);
   [baggedTPR,baggedFPR,baggedF1] = CalcTRPFPR(baggedconf);
       
      Fin3{j}{1} = baggedTPR;
      Fin3{j}{2} = baggedFPR;
      Fin3{j}{3} = baggedF1;
      Fin3{j}{4} = baggedconf;
end

end

