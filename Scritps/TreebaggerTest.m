op = statset('UseParallel',true);
rng(2);
ind = [1 2 3 4 5 6 7 8 9]; %crossvalind('Kfold',length(All4),length(All4)); %[1 2 3 4 5 6 7 8 9];%
parfor c =1:length(Methods)
Package{c} = InnerTreeBagger(All5,'TotalBoost',ind);
end


Package{1} = InnerTreeBagger(All5,'TotalBoost',ind);
% 
[ Conf,TempTPR,TempFPR,TempF1 ] = InnerTreeBagger( All5,'TotalBoost',ind,op);
% 
% b = TreeBagger(100,Data(:,1:28),Data(:,end),'Method','classification','OOBVarImp','On',...
%     'NumPredictorsToSample',14,...
%     'MinLeafSize',5,...
% 'OOBPrediction','on',...
% 'Options',op);
% 
% Data = [];
% for i = 1:2
%     Data = vertcat(Data,All5{1});
% end
% 
% 
% prd = predict(b,test(:,1:28)) %b.predict(test(:,1:28))
% 
% confusionmat(as,test(:,end))
% 
% 
% cell2table(prd)
% 
% test = All5{9};
% 
% op = statset('UseParallel',True)