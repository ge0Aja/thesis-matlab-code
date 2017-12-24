function [acc ForestTPR ForestFPR ForestF1] = parRandForest( Data,learnForest,predForest,leafForest,indic,itr,Useriter )
% 
% % finalacc,finaltpr,finalfpr,finalf1
% %UNTITLED8 Summary of this function goes here
% %   Detailed explanation goes here
% % parfor i=1:3
% %     testind = (indic == i);
% %     trainind = ~testind;
% 
% tic
%     RandForest =  trainRandomForest(Data{1}(:,:),learnForest,predForest,leafForest);
%    toc
%      fprintf('the time consumed to train for user %d RF \n\n',Useriter);
%    tic
%     prd = predict(RandForest,Data{2}(:,1:28));
% toc
% fprintf('the time consumed to test for user %d RF \n\n',Useriter);
%     %     mat = cell2mat(prd);
% %     as = str2num(mat);
% %      Forestconf = confusionmat(Traindata(testind,end),as);
% %     [ForestTPR(i,:),ForestFPR(i,:),ForestF1(i,:)] = CalcTRPFPR(Forestconf);
% %     acc(i)=100*sum(as==Traindata(testind,end))/length(as);
% % %         fprintf('finished for Random Forest in Fold %d for local iteration %d for User %d\n',i,itr,Useriter);
% % end
% % finalacc = mean(acc);
% % finaltpr = mean(ForestTPR);
% % finalfpr = mean(ForestFPR);
% % finalf1 = mean(ForestF1);

%% for OOB [true false true true false true false false true true false false false false false false false true true true true true true true false true false false false]

 RandForest =  trainRandomForest(Data{1}(:,:),learnForest,predForest,leafForest);
prd = predict(RandForest,Data{2}(:,[false false false true true false false false false false true true true true false true true true false true false true false true true true false false false]));
 mat = cell2mat(prd);
 as = str2num(mat);
acc=100*sum(as==Data{2}(:,end))/length(as);
 Forestconf = confusionmat(Data{2}(:,end),as);
[ForestTPR(1,:),ForestFPR(1,:),ForestF1(1,:)] = CalcTRPFPR(Forestconf);

 fprintf('Finished Training and Testing for user %d RF \n\n',Useriter);
end

