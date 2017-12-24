function [ GausSVMResults,QuadSVMResults,RandForestResults,BaggedResults,KNNResults ] = TuneUsers( DataSets,N )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
parfor j =1:length(DataSets)
[ GausSVMResults{j},QuadSVMResults{j},RandForestResults{j},BaggedResults{j},KNNResults{j}] = Tuneparams( DataSets{j}{1},N,j);
% fprintf('finished for user %d\n',j);
end

end

