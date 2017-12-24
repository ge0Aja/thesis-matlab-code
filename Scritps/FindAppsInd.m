function [ AppsInd,minw,arrzero ] = FindAppsInd( data )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    AppsInd{1} = (data(:,end) == 1);
    AppsInd{2} = (data(:,end) == 2);
    AppsInd{3} = (data(:,end) == 3);
    AppsInd{4} = (data(:,end) == 4);
    AppsInd{5} = (data(:,end) == 5);
    AppsInd{6} = (data(:,end) == 6);
    
    arrasdasd = [sum(AppsInd{1}) sum(AppsInd{2}) sum(AppsInd{3}) sum(AppsInd{4}) sum(AppsInd{5}) sum(AppsInd{6})]; 
    arrzero = (arrasdasd == 0);
    minw = min(arrasdasd(arrasdasd>0));
end

