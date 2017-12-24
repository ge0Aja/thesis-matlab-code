function [ acc,QuadTPR,QuadFPR,QuadF1 ] = parQuadSVM( Data,polydegree,boxconst,indic,itr,Useriter)

% % UNTITLED9 Summary of this function goes here
% %   Detailed explanation goes here
% tic
% parfor i=1:3
%     testind = (indic == i);
%     trainind = ~testind;
%     QuadSvm =  trainSVMQuad(Data{1}(trainind,:),polydegree,boxconst);
% % toc
% % fprintf('the time consumed to train for user %d Quad \n\n',Useriter);
% 
% % tic
% pred = predict(QuadSvm.ClassificationSVM,Data{2}(:,1:28));
%     acc(i)=100*sum(pred==Traindata(testind,end))/length(pred);
%      Quadconf = confusionmat(Traindata(testind,end),pred);
%     [QuadTPR(i,:),QuadFPR(i,:),QuadF1(i,:)] = CalcTRPFPR(Quadconf);
% %     fprintf('finished for Quad in Fold %d for local iteration %d for User %d\n',i,itr,Useriter);
% end
% finalacc = mean(acc);
%  finaltpr = mean(QuadTPR);
%     finalfpr = mean(QuadFPR);
%     finalf1 = mean(QuadF1);
    
%  toc
%  fprintf('the time consumed to test for user %d Quad \n\n',Useriter);

QuadSvm =  trainSVMQuad(Data{1}(:,:),polydegree,boxconst);
pred = predict(QuadSvm.ClassificationSVM,Data{2}(:,1:28));

acc =100*sum(pred==Data{2}(:,end))/length(pred);
Quadconf = confusionmat(Data{2}(:,end),pred);
[QuadTPR(1,:),QuadFPR(1,:),QuadF1(1,:)] = CalcTRPFPR(Quadconf);

 fprintf('Finished Training and Testing for user %d Quad \n\n',Useriter);
end

