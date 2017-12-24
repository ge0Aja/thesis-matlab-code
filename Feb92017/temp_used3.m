% clear ttpr
% clear ffpr
% clear ResRes
% clear ff1
% clear conf
% clear Classifier
% clear f1
% 
% 
% 
% [tr_sk,te_sk] =  getTrain_Test(d6,10,[5]);
% [tr_v,te_v] =  getTrain_Test(d7,20,[7]);
% parfor i = 1 : 30
% [tr,te] = getTrain_Test(d7,1,unique(d7(:,32)));
% %     [~,ResRes{i}] = parRandForesttest(tr,te,30,28,10);
% Classifier{i} = trainClassifierBagged(tr);
% pred{i} = Classifier{i}.predictFcn(te(:,1:28));
% conf{i} = confusionmat(te(:,32),pred{i});
% [ttpr{i},ffpr{i},ff1{i}]= CalcTRPFPR(conf{i});
% end
% for i = 1: 30
% f1(i,:) = ff1{i};
% end
% 
% 
% 
% parfor i = 1:9
%     [Merged_Dataset{i}] = KKFolds(i,Data_Sets,Label,Extra_Apps,Extra_Labels,game_321_2);
% end



parfor i = 1 : 9
    for j = 1 : 9
     [Classi{i}{j},ParResKnown{i}{j}] = parRandForesttest(Merged_Dataset{i}{1}(Merged_Dataset{i}{1}(:,32) ~= j,:),Merged_Dataset{i}{2}(Merged_Dataset{i}{2}(:,32) ~= j,:),30,18,14);
%      prdUnknown{i}{j} = predict(Classi{i}{j},Merged_Dataset{i}{2}(Merged_Dataset{i}{2}(:,32) == j,:));   
     fprintf('finished for App %d\n',j)
    end
    fprintf('\nfinished for Dataset %d\n',i)
end