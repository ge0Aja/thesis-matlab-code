function [ X ] = DropShort( X,x )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
for i=1:length(X)
    %test = X{i};
    testsum = sum(X{i}(:,4));
    if(testsum  < x)
        X{i}=[];
    end
end

 X= X(~cellfun('isempty',X));
end

