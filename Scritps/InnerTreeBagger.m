function [ Conf,TempTPR,TempFPR,TempF1 ] = InnerTreeBagger( All5,Method,ind,op)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
parfor k = 1 : length(All5)
      testingdata = [];
      data = [];
    for i = 1 : length(All5)
        if(ind(i) == k)
          testingdata = vertcat(testingdata,All5{i});
        else
            data = vertcat(data,All5{i}); %balanced
        end
    end
    b = TreeBagger(100,data(:,1:28),data(:,end),'Method','classification','OOBVarImp','On',...
    'NumPredictorsToSample',18,...
    'MinLeafSize',5,...
'OOBPrediction','on',...
'Options',op);
% 
% b = fitensemble(data(:,1:28), data(:,end), Method, 200, 'Tree', 'Type', 'Classification', 'ClassNames', [1 2 3 4 5 6]);
 prd = predict(b,testingdata(:,1:28));
% 
mat{k} = cell2mat(prd);
as{k} = str2num(mat{k});
Conf{k} = confusionmat(as{k},testingdata(:,end)); %prd
[ TempTPR(k,:),TempFPR(k,:),TempF1(k,:)] = CalcTRPFPR(Conf{k});
end


end

