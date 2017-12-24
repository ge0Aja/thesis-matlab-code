function [ FinalStats ] = GetStatsFlows( X,Thresh,Label )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

for i=1:length(X)
    if(i ==1)
        %% GetStats(X{i}(:,2),X{i}(:,3),X{i}(:,4),X{i}(:,5),Thresh);
    FinalStats = GetStats(X{i}(:,2),X{i}(:,3),X{i}(:,4),X{i}(:,5),Thresh);
    else
        %% GetStats(X{i}(:,2),X{i}(:,3),X{i}(:,4),X{i}(:,5),Thresh);
        TempStats = GetStats(X{i}(:,2),X{i}(:,3),X{i}(:,4),X{i}(:,5),Thresh);
        %%
        FinalStats = vertcat(FinalStats,TempStats);
    end  
end

FinalStats(:,end+1) = Label;

indices = find(FinalStats(:,2)==0);
FinalStats(indices,:) = [];


indices = find(FinalStats(:,1)==0);
FinalStats(indices,:) = [];



indices = find(FinalStats(:,2)==1);
FinalStats(indices,:) = [];


indices = find(FinalStats(:,1)==1);
FinalStats(indices,:) = [];

end

