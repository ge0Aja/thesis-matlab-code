parfor i=1:9
%     Gaus{i} = TrainSingleClassSVMGaus( DataSets{i},snap );
    Quad{i} = TrainSingleClassSVMQuad( DataSets{i},snap )
end




parfor i=1:9
%     Gaus{i} = TrainSingleClassSVMGaus( DataSets{i},snap );
    Dist{i} = CalcKNNDistances( DataSets{i},snap )
end