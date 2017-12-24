function [ All ] = Finale(FacebookStats1,GameStats1,SkypeStats1,WhatsAppStats1,YoutubeStats1,FacebookStats2,GameStats2,SkypeStats2,WhatsAppStats2,YoutubeStats2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
first = 1;
    for i=1:5
        for j=1:5
            if(j ~= i)
                if(first == 1)
                    TrainData = FacebookStats1{j};
                    TestData = FacebookStats2{i};
                    first = 0;
                else
                            TrainData = vertcat(TrainData,FacebookStats1{j});
                            TestData = vertcat(TestData,FacebookStats2{j});
                end
        TrainData = vertcat(TrainData,GameStats1{j});
        TrainData = vertcat(TrainData,SkypeStats1{j});
       % TrainData = vertcat(TrainData,VoipStats1{j});
        TrainData = vertcat(TrainData,WhatsAppStats1{j});
        TrainData = vertcat(TrainData,YoutubeStats1{j});
            end
        end
        first =1;
        TrainClasses = TrainData(:,end);
        TrainData(:,end) = [];
        %for j=1:5
        %    if(j ~= i)
        
        TestData = vertcat(TestData,GameStats2{i});
        TestData = vertcat(TestData,SkypeStats2{i});
       % TestData = vertcat(TestData,VoipStats2{i});
        TestData = vertcat(TestData,WhatsAppStats2{i});
        TestData = vertcat(TestData,YoutubeStats2{i});
        
        TestClasses = TestData(:,end);
        TestData(:,end) = [];
        myClassifier = ClassificationTree.fit(TrainData, TrainClasses);
        res = myClassifier.predict(TestData);
        ConfusionMatrix = CalcConf(res,TestClasses);
        [TPR,FPR,TP,FP,FN,TN] = CalcTRPFPR(ConfusionMatrix);

        All{i,1} = TPR;
        All{i,2} = FPR;
        All{i,3} = TP;
        All{i,4} = FP;
        All{i,5} = FN;
        All{i,6} = TN;
        All{i,7} = ConfusionMatrix;
        %    end
       % end
      %  first = 1;
        
    end
end

