function [acc,KNNTPR,KNNFPR,KNNF1] = parKNN( Data,subspaceDimension,learnersnum,neighborKNN,indic,itr,Useriter)
% 
% %finalacc,finaltpr,finalfpr,finalf1
% %UNTITLED7 Summary of this function goes here
% %   Detailed explanation goes here
% % tic
% % parfor i=1:3
% % testind = (indic == i);
% %     trainind = ~testind;
%     KnnSub =  trainClassifierKNN(Data{1}(:,:),subspaceDimension,learnersnum,neighborKNN);
%     
% %     toc
% %     fprintf('the time consumed to train for user %d KNN \n\n',Useriter);
%     tic
%     pred = predict(KnnSub.ClassificationEnsemble,Data{2}(:,1:28));
% %     acc(i)=100*sum(pred==Traindata(testind,end))/length(pred);
% %      KNNconf = confusionmat(Traindata(testind,end),pred);
% %     [KNNTPR(i,:),KNNFPR(i,:),KNNF1(i,:)] = CalcTRPFPR(KNNconf);
% %      fprintf('finished for KNN in Fold %d for local iteration %d for User %d\n',i,itr,Useriter);
% % end
% %  finalacc = mean(acc);
% %  finaltpr = mean(KNNTPR);
% %     finalfpr = mean(KNNFPR);
% %     finalf1 = mean(KNNF1);
% toc
%    fprintf('the time consumed to test for user %d KNN \n\n',Useriter);



KnnSub =  trainClassifierKNN(Data{1}(:,:),subspaceDimension,learnersnum,neighborKNN);
 pred = predict(KnnSub.ClassificationEnsemble,Data{2}(:,[true false false true false false false true false	true false true false true false true false true false true false true false true false true true true]));

acc=100*sum(pred==Data{2}(:,end))/length(pred);
KNNconf = confusionmat(Data{2}(:,end),pred);
[KNNTPR(1,:),KNNFPR(1,:),KNNF1(1,:)] = CalcTRPFPR(KNNconf);

 fprintf('Finished Training and Testing for user %d KNN \n\n',Useriter);

end

