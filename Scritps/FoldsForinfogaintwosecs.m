for h = 1 : 19
for j = 1 : 4
    Trainset = [];
    Testset = [];
    for i = 1 : length(AllTwoSecs{h})
        Testres {i} = AllTwoSecs{h}{i}{j};
        Trainres {i} = AllTwoSecs{h}{i};
        Trainres {i}(:,j) = [];  
    end  
    
    for k = 1 : length(Trainres)
        for m = 1 : length(Trainres{k})
            Trainset = vertcat(Trainset,Trainres{k}{m});
        end
    end
    
    for l=1:length(Testres)
        Testset = vertcat(Testset,Testres{l});
    end
    
    TrainClasses = Trainset(:,end);
    Trainset(:,end) = [];
    myClassifier = ClassificationTree.fit(Trainset, TrainClasses);
    
    
    TestClasses = Testset(:,end);
    Testset(:,end) = [];
        
    res = myClassifier.predict(Testset);  
    ConfusionMatrix = CalcConf(res,TestClasses);  
    [TPR,FPR,TP,FP,FN,TN] = CalcTRPFPR(ConfusionMatrix);
       
     Fin{h}{j,1} = TPR;
     Fin{h}{j,2} = FPR;
     Fin{h}{j,3} = TP;
     Fin{h}{j,4} = FP;
     Fin{h}{j,5} = FN;
     Fin{h}{j,6} = TN;
     Fin{h}{j,7} = ConfusionMatrix;
end
end
