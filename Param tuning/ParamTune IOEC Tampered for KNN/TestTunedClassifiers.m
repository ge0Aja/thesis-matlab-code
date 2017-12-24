parfor i=1:9
    %%
% %       BaggedResults{i} = parbaggtest(DataSets{i},Bagglearner,i);
%     
%     baggedcl{i} = trainClassifierBaggedTreesComplete(DataSets{i}{1},Bagglearner(i));
%     predbagg = predict(baggedcl{i},DataSets{i}{2}(:,1:28));
%     accbagg(i)=100*sum(predbagg==DataSets{i}{2}(:,end))/length(predbagg);
%     baggedconf = confusionmat(DataSets{i}{2}(:,end),predbagg);
%     [baggedTPR(i,:),baggedFPR(i,:),baggedF1(i,:)] = CalcTRPFPR(baggedconf);
%     
%     fprintf('finished for bagged For %d Dataset\n',i);
    %%
% %     GausResults{i} = parSVMGaustest(DataSets{i},Gauskernel,Gausbox,i);
%     
%     GaussianSvmcl{i} =  trainSVMGuas(DataSets{i}{1},Gauskernel(i),Gausbox(i));
%     predGaus = predict(GaussianSvmcl{i}.ClassificationSVM,DataSets{i}{2}(:,1:28));
%     accGaus(i)=100*sum(predGaus==DataSets{i}{2}(:,end))/length(predGaus);
%     Gausconf = confusionmat(DataSets{i}{2}(:,end),predGaus);
%     [GausTPR(i,:),GausFPR(i,:),GausF1(i,:)] = CalcTRPFPR(Gausconf);
%      fprintf('finished for gaussian For %d Settings\n',i);
    %%
% %     QuadResults{i} = parSVMQuadtest( DataSets{i},polyorder,Quadbox,i);
%     QuadSvmcl{i} =  trainSVMQuad(DataSets{i}{1},polyorder(i),Quadbox(i));
%      predQuad = predict(QuadSvmcl{i}.ClassificationSVM,DataSets{i}{2}(:,1:28));
%     accQuad(i)=100*sum(predQuad==DataSets{i}{2}(:,end))/length(predQuad);
%      Quadconf = confusionmat(DataSets{i}{2}(:,end),predQuad);
%     [QuadTPR(i,:),QuadFPR(i,:),QuadF1(i,:)] = CalcTRPFPR(Quadconf);
%      fprintf('finished for Quad For %d Settings\n',i);
    %%
    KNNResults{i} = parKnntest( DataSets{i},KnnPredict,Knnlearner,KnnNeighbors,i);
%     KnnSubcl{i} =  trainClassifierKNN(DataSets{i}{1},KnnPredict(i),Knnlearner(i));
%      predKnn = predict(KnnSubcl{i}.ClassificationEnsemble,DataSets{i}{2}(:,1:28));
%     accknnSub(i)=100*sum(predKnn==DataSets{i}{2}(:,end))/length(predKnn);
%      KNNconf = confusionmat(DataSets{i}{2}(:,end),predKnn);
%     [KNNTPR(i,:),KNNFPR(i,:),KNNF1(i,:)] = CalcTRPFPR(KNNconf);
%      fprintf('finished for KNN For %d Settings\n',i);
    %%
% %     RandForestResults{i} = parRandForesttest( DataSets{i},Forestlearner,ForestPredict,Forestleaf,i);
%     RandForestcl{i} =  trainRandomForest(DataSets{i}{1},Forestlearner(i),ForestPredict(i),Forestleaf(i));
%      prdRandForest = predict(RandForestcl{i},DataSets{i}{2}(:,1:28));
%     mat = cell2mat(prdRandForest);
%     as = str2num(mat);
%      Forestconf = confusionmat(DataSets{i}{2}(:,end),as);
%     [ForestTPR(i,:),ForestFPR(i,:),ForestF1(i,:)] = CalcTRPFPR(Forestconf);
%     accRandomForest(i)=100*sum(as==DataSets{i}{2}(:,end))/length(as);
%      fprintf('finished for Random Forest For %d Settings\n',i);
    %%
end