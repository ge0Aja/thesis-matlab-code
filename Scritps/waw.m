parfor i=1:length(DataSets)
     bagged = trainClassifierBaggedTreesComplete(DataSets{i}{1}); 
      Fin3{i} = FoldUser(DataSets{i},bagged);
end
FinalTPR = [];
FinalFPR = [];
FinalF1 = [];
for i=1:length(Fin3)
    TPR = [];
    FPR = [];
    F1 = [];
    for j = 1:length(Fin3{i})
    TPR = vertcat(TPR,Fin3{i}{j}{1});
    FPR = vertcat(FPR,Fin3{i}{j}{2});
    F1 = vertcat(F1,Fin3{i}{j}{3});
    end
    FinalTPR = vertcat(FinalTPR,mean(TPR));
    FinalFPR = vertcat(FinalFPR,mean(FPR));
    FinalF1 = vertcat(FinalF1,mean(F1));
end