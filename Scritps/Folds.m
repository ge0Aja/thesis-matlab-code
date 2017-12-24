function [ Fin ] = Folds( All )

for j = 1 : 6
    Trainset = [];
    Testset = [];
    for i = 1 : length(All)
        Testres {i} = All{i}{j};
        Trainres {i} = All{i};
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
       
     Fin{j,1} = TPR;
     Fin{j,2} = FPR;
     Fin{j,3} = TP;
     Fin{j,4} = FP;
     Fin{j,5} = FN;
     Fin{j,6} = TN;
     Fin{j,7} = ConfusionMatrix;
end
        
    

end

