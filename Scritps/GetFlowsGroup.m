function [ XFlows ] = GetFlowsGroup( X,x,y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for i=1:size(X,1)
    TempFlows = GetFlowsEdit(X{i,4},X{i,7},X{i,1},X{i,8},X{i,2},X{i,5},X{i,9},X{i,3},x);
    TempFlows = DropShort(TempFlows,y);
    XFlows{i} = TempFlows;
end

end

