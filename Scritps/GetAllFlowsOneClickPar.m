function [ AllFlows ] = GetAllFlowsOneClickPar( AllMins,HomeIP,FlowLength)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if(~isempty(AllMins))
    AllFlows = GetFlowsGroupPar(AllMins,{HomeIP},FlowLength);
end

end

