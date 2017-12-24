tic
parfor j =1:length(DataSets)
[ GausSVMResults{j},QuadSVMResults{j},RandForestResults{j},BaggedResults{j},KNNResults{j}] = Tuneparams( DataSets{j}{1},30,j);
fprintf('finished for user %d\n',j);
end
toc