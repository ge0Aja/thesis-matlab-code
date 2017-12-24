function [ AllStats ] = GetAllStatsOneClickPar( AllFlows,ThreshSmall,Label )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
 if(~isempty(AllFlows))
    AllStats = GetGroupStatsPar(AllFlows,ThreshSmall,Label);
 end

end

