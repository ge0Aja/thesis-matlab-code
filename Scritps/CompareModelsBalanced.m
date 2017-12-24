function [ Fin ] = CompareModelsBalanced( N,newdata,testdata,AppsInd,min,testAppsInd,testmin,testzeros)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% 
% quadTPRs = [];
% quadFPRs = [];
% 
% guasTPRs = [];
% guasFPRs = [];
% 
% baggedTPRs = [];
% baggedFPRs = [];
% 
% complexTPRs = [];
% complexFPRs = [];
   
%     newdata = newdata(randperm(size(newdata,1)),:);
%     newdata = newdata(randperm(size(newdata,1)),:);
%      bagged = trainClassifierBaggedTreesComplete(newdata);
%      knn = trainClassifierSubspaceKnn(newdata);
%      svmguas = trainSVMGuas(newdata);

parfor i=1:N
    rng(2);
    balanced = [];
    balancedtest = [];
    for k=1:6
%         if(sum(AppsInd{k}) ~= 0)
      TempMatr = [];
      TempMatr = newdata(AppsInd{k},:);
      c = randperm(length(TempMatr),min);
      balanced = vertcat(balanced,TempMatr(c,:));
%         else
%             continue;
%         end      
     if(sum(testAppsInd{k}) ~= 0)
        TempMatrTest = [];
        TempMatrTest = testdata(testAppsInd{k},:);
        c1 = randperm(length(TempMatrTest),testmin);
        balancedtest = vertcat(balancedtest,TempMatrTest(c1,:));
     else
         continue;
     end
%     elseif(~isempty(testzeros) && testzeros(k) ~= 1)
%         TempMatrTest = testdata(testAppsInd{k},:);
%         c1 = randperm(length(TempMatrTest),testmin);
%         balancedtest = vertcat(balancedtest,TempMatrTest(c1,:));
%     end
    
    end
    %train the classifiers using the balanced training 
%     svmquad = trainSVMQuad(balanced);
%       svmguas = trainSVMGuas(balanced);
       bagged = trainClassifierBaggedTreesComplete(balanced);
%       knn = trainClassifierSubspaceKnn(balanced);
%     complex = trainComplexTree(balanced);

%%
%     [acc3x100] = AnnProc(balanced,testdata,3,100,'logsig','mse','traingd',0.1);
%     [acc4x100] = AnnProc(balanced,testdata,4,100,'logsig','mse','traingd',0.2);
%     [acc3x100c] = AnnProc(balanced,testdata,3,100,'logsig','crossentropy','traingd',0.1);
%      [acc4x100c,acc4x100tp,acc4x100fp,acc4x100f1] = AnnProc(balanced,testdata,4,100,'logsig','crossentropy','traingd',0.2);
%     [acc3x200] = AnnProc(balanced,testdata,3,200,'logsig','mse','traingd',0.3);
%     [acc4x200] = AnnProc(balanced,testdata,4,200,'logsig','mse','traingd',0.1);
%     [acc3x200c] = AnnProc(balanced,testdata,3,200,'logsig','crossentropy','traingd',0.4);
%     [acc4x200c] = AnnProc(balanced,testdata,4,200,'logsig','crossentropy','traingd',0.5);
%     [acc3x200cR] = AnnProc(balanced,testdata,3,200,'logsig','crossentropy','traingd',0.9);
%     [acc3x100cR] = AnnProc(balanced,testdata,3,100,'logsig','mse','traingd',0.9);
%     
%     Fin{i}{1} = acc3x100;
%     Fin{i}{2} = acc4x100;
%     Fin{i}{3} = acc3x100c;
%     Fin{i}{4} = acc4x100c;
%     Fin{i}{5} = acc3x200;
%     Fin{i}{6} = acc4x200;
%     Fin{i}{7} = acc3x200c;
%     Fin{i}{8} = acc4x200c;
%     Fin{i}{9} = acc3x200cR;
%     Fin{i}{10} = acc3x100cR;
% Fin{i}{1} = acc4x100c;
% Fin{i}{2} = acc4x100tp;
% Fin{i}{3} = acc4x100fp;
% Fin{i}{4} = acc4x100f1;
%%
    %predict the outcome of the classifiers
%     predsvmquad = predict(svmquad.ClassificationSVM,testdata(:,1:28));
%       predsvmguas = predict(svmguas.ClassificationSVM,balancedtest(:,1:28));
%       predknn = predict(knn.ClassificationEnsemble,balancedtest(:,1:28));
    % predbagged = predict(bagged,balancedtest(:,[false false false true true false false false false false false true false false false true false false false false false false false true false false false false])); %.ClassificationEnsemble
     
      predbagged = predict(bagged,balancedtest(:,1:28)); %.ClassificationEnsemble
%     predcomplex = predict(complex.ClassificationTree,testdata(:,1:28));
    
    %calc conf
    
%     quadconf = confusionmat(testdata(:,end),predsvmquad);
%       guasconf = confusionmat(balancedtest(:,end),predsvmguas);
     baggedconf = confusionmat(balancedtest(:,end),predbagged);
%       knnconf = confusionmat(balancedtest(:,end),predknn);
%     complexconf = confusionmat(testdata(:,end),predcomplex);
%     
%     [quadTPR,quadFPR,quadF1] = CalcTRPFPR( quadconf );
     try
%       [guasTPR,guasFPR,guasF1] = CalcTRPFPR( guasconf );
     [baggedTPR,baggedFPR,baggedF1] = CalcTRPFPR( baggedconf );
%       [knnTPR,knnFPR,knnF1] = CalcTRPFPR( knnconf );
     catch
         fprintf('failure on iteration %d',i);
        continue;
     end
%     [complexTPR,complexFPR,complexF1] = CalcTRPFPR( complexconf );
    %save all TPRs FPRs .....
    
%     quadTPRs = vertcat(quadTPRs,quadTPR);
%     quadFPRs = vertcat(quadFPRs,quadFPR);
%     
%     guasTPRs = vertcat(guasTPRs,guasTPR);
%     guasFPRs = vertcat(guasFPRs,guasFPR);
%     
%     baggedTPRs = vertcat(baggedTPRs,baggedTPR);
%     baggedFPRs = vertcat(baggedFPRs,baggedFPR);
%     
%     complexTPRs = vertcat(complexTPRs,complexTPR);
%     complexFPRs = vertcat(complexFPRs,complexFPR);
%     
%     Fin{i}{1} = quadTPR;
%     Fin{i}{2} = quadFPR;
%       Fin{i}{7} = guasTPR;
%       Fin{i}{8} = guasFPR;
%       Fin{i}{9} = guasF1;
     Fin{i}{1} = baggedTPR;
     Fin{i}{2} = baggedFPR;
     Fin{i}{3} = baggedF1;
%       Fin{i}{4} = knnTPR;
%       Fin{i}{5} = knnFPR;
%       Fin{i}{6} = knnF1;
%     Fin{i}{7} = complexTPR;
%     Fin{i}{8} = complexFPR;
%     Fin{i}{9} = guasF1;
%     Fin{i}{10} = complexF1;
%     
%
    
    %get the average after all interations    
end
end
