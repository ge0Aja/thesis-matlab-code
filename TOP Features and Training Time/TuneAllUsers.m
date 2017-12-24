tic
parfor j =1:length(DataSets)
[ KNNResults{j}] = Tuneparams(DataSets{j}{1},10,j);

%%%GausSVMResults{j},QuadSVMResults{j},RandForestResults{j},BaggedResults{j},
fprintf('finished for user %d\n',j);
end
toc