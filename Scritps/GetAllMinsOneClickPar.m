function [ AllMins ] = GetAllMinsOneClickPar( DataCell,ThreshBig,RowsToDel )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
 if(~isempty(DataCell))
    AllMins = GetMins(DataCell,ThreshBig);
 end
    fprintf('Got the Minutes');
    while(size(AllMins,1) > RowsToDel-1)
        if(~isempty(AllMins))
         AllMins(RowsToDel,:) = [];
        end
    end
end

