function [acc baggedTPR baggedFPR  baggedF1 ] = parbagg( Data,numlearners,indic,itr,Useriter)
%finalacc,finaltpr,finalfpr,finalf1

% %UNTITLED5 Summary of this function goes here
% %   Detailed explanation goes here
% tic
% % parfor i=1:3
% %     testind = (indic == i);
% %     trainind = ~testind;
%    % Bagged =  trainClassifierBaggedTreesComplete(Traindata(trainind,:),numlearners);
%      Bagged =  trainClassifierBaggedTreesComplete(Data{1}(:,:),numlearners);
% toc
% fprintf('the time consumed to train for user %d Bagg \n\n',Useriter);
% 
% tic  
%      pred = predict(Bagged,Data{2}(:,1:28));
% %     acc(i)=100*sum(pred==Traindata(testind,end))/length(pred);
% %     baggedconf = confusionmat(Traindata(testind,end),pred);
% %     [baggedTPR(i,:),baggedFPR(i,:),baggedF1(i,:)] = CalcTRPFPR(baggedconf);
%     
% %     fprintf('finished for Bagged in Fold %d for local iteration %d for User %d\n',i,itr,Useriter);
% % end
% %     finalacc = mean(acc);
% %     finaltpr = mean(baggedTPR);
% %     finalfpr = mean(baggedFPR);
% %     finalf1 = mean(baggedF1);
% toc 
% fprintf('the time consumed to test for user %d Bagg \n\n',Useriter);
% 
% 
 Bagged =  trainClassifierBaggedTreesComplete(Data{1}(:,:),numlearners);
 % for OOB [true true false true false false false false false true true true false true false false true true false true true true true false false true false false false]
 %edited for info gain
 pred = predict(Bagged,Data{2}(:,[false false false true true false false false false false true true true true false true true true false true false true false true true true false false false]));

acc=100*sum(pred==Data{2}(:,end))/length(pred);
 baggedconf = confusionmat(Data{2}(:,end),pred);
[baggedTPR(1,:),baggedFPR(1,:),baggedF1(1,:)] = CalcTRPFPR(baggedconf);

 fprintf('Finished Training and Testing for user %d bagged \n\n',Useriter);
end


