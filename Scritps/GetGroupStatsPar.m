function [ GroupStats ] = GetGroupStatsPar( X,Thresh,Label)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
GroupStats = cell(length(X));
X = X(~cellfun('isempty',X));
parfor i =1 : length(X)
    TempStats = GetStatsFlows(X{i},Thresh,Label);
    GroupStats{i} = TempStats;
    fprintf('Got the Stats for Flow %d',i);
end


end

