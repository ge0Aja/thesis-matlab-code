function [ GroupStats ] = GetGroupStats( X,Thresh,Label)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
X = X(~cellfun('isempty',X));
for i =1 : length(X)
    TempStats = GetStatsFlows(X{i},Thresh,Label);
    GroupStats{i} = TempStats;
end


end

