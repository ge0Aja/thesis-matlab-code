ind = [1 2 3 4 5 6 7 8 9]; %crossvalind('Kfold',length(All4),length(All4)); %[1 2 3 4 5 6 7 8 9];%
parfor k = 1 : length(All5)
      testingdata = [];
      data = [];
    for i = 1 : length(All5)
        if(ind(i) == k)
          testingdata = vertcat(testingdata,All5{i});
        else
%             balanced = [];
%             [AppsIndUser,minUser,testzerosUser]  = FindAppsInd(All5{i});
%             for j = 1 :6
%                 if(sum(AppsIndUser{j}) ~= 0)
%               TempMatr = [];
%               TempMatr = All5{i}(AppsIndUser{j},:);
%               c = randperm(length(TempMatr),minUser); %
%               balanced = vertcat(balanced,TempMatr(c,:)); 
%                 end
%             end
            data = vertcat(data,All5{i}); %balanced
        end
    end
     [testAppsInd,testmin,trainzeros]  = FindAppsInd(testingdata);
     [AppsInd,min,testzeros]  = FindAppsInd(data);
%      try
%          Finss{k} = CompareModelsBalanced(30,data,testingdata,AppsInd,min,testAppsInd,30,testzeros);
%      catch
%          fprintf('failure for user %d',k);
%          continue;
%      end
        DataSets{k}{1} = data;
        DataSets{k}{2} = testingdata;

%     % svmguas = trainSVMGuas(data);
%      bagged = trainClassifierBaggedTree(data);
%      
%      predbagged = predict(bagged,testingdata(:,[true true false true true false false false false false false true false true false true false false false false true false true false true false false false]));
%      %predsvmguas = predict(svmguas.ClassificationSVM,testingdata(:,1:28));
%      
%      %guasconf = confusionmat(testingdata(:,end),predsvmguas);
%      baggedconf = confusionmat(testingdata(:,end),predbagged);
%      
%      %[guasTPR,guasFPR,guasF1] = CalcTRPFPR( guasconf );
%      [baggedTPR,baggedFPR,baggedF1] = CalcTRPFPR(baggedconf);
%      
%      %Fin2{k}{1} = guasTPR;
%      %Fin2{k}{2} = guasFPR;
%      %Fin2{k}{3} = guasF1;
%      Fin2{k}{1} = baggedTPR;
%      Fin2{k}{2} = baggedFPR;
%      Fin2{k}{3} = baggedF1;
end

%  fok
    