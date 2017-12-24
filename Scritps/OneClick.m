function [ Every ] = OneClick( ThreshBig,ThreshSmall,FlowLength,RowsToDel,Data)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
%n = nargin-4;
n= length(Data);
Label = 0;
AllMins = cell(n);
AllFlows = cell(n);
AllStats = cell(n);
Every = cell(n);
for i=1:n
    %if(mod(i,2) && i~= 1)
    Label = Label + 1;
    %end
    if(~isempty(Data{i}))
    AllMins{i} = GetMins(Data{i},ThreshBig);
    end
    while(size(AllMins{i},1) > RowsToDel-1)
    AllMins{i}(RowsToDel,:) = [];
    end
%     if(~isempty(AllMins{i}))
%     AllFlows{i} = GetFlowsGroup(AllMins{i},{'192.168.137.69'},FlowLength);
%     end
%     if(~isempty(AllFlows{i}))
%     AllStats{i} = GetGroupStats(AllFlows{i},ThreshSmall,Label);
%     end
%     Every{i} = AllStats{i};
%     if(mod(i,2))      
%         Train{i} = AllStats{i};
%     else
%         Test{i} =  AllStats{i};
%     end
end
%       Train = Train(~cellfun('isempty',Train));
%       Test =  Test(~cellfun('isempty',Test));
%    
      
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 vs. 1 Train and  Calssify     
%     for j =1:5 
%           TrainSet = Train{1}{j};
%           TestSet = Test{1}{j};
%       for i =2:length(Train)
%           TrainSet = vertcat(TrainSet,Train{i}{j});
%           TestSet = vertcat(TestSet,Test{i}{j});
%       end
%         TrainClasses = TrainSet(:,end);
%         TrainSet(:,end) = [];
%         
%         TestClasses = TestSet(:,end);
%         TestSet(:,end) = [];
%         
%         myClassifier = ClassificationTree.fit(TrainSet, TrainClasses);
%         res = myClassifier.predict(TestSet);
%         
%         ConfusionMatrix = CalcConf(res,TestClasses);
%         
%         [TPR,FPR,TP,FP,FN,TN] = CalcTRPFPR(ConfusionMatrix);
%        
%         All{j,1} = TPR;
%         All{j,2} = FPR;
%         All{j,3} = TP;
%         All{j,4} = FP;
%         All{j,5} = FN;
%         All{j,6} = TN;
%         All{j,7} = ConfusionMatrix;
%     end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 vs. 1 Train and  Calssify  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% all vs. all Train and  Calssify  
%       for i =1:length(Train)
%           for j =1:length(Train{i})
%               if(j == 1 && i == 1)
%                 TrainSet = Train{i}{j};
%                 TestSet = Test{i}{j};
%               end
%               TrainSet = vertcat(TrainSet,Train{i}{j});
%               TestSet = vertcat(TestSet,Test{i}{j});
%           end
%       end
%       
%        TrainClasses = TrainSet(:,end);
%        TrainSet(:,end) = [];
%         
%        TestClasses = TestSet(:,end);
%        TestSet(:,end) = [];
% 
%        myClassifier = ClassificationTree.fit(TrainSet, TrainClasses);
%        res = myClassifier.predict(TestSet);
% 
%        ConfusionMatrix = CalcConf(res,TestClasses);
% 
%        [TPR,FPR,TP,FP,FN,TN] = CalcTRPFPR(ConfusionMatrix);
%        
%        All{j,1} = TPR;
%        All{j,2} = FPR;
%        All{j,3} = TP;
%        All{j,4} = FP;
%        All{j,5} = FN;
%        All{j,6} = TN;
%        All{j,7} = ConfusionMatrix;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% all vs. all Train and  Calssify  

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% all vs. 1 Train and  Calssify 
% 
%  for i =1:length(Train)
%           for j =1:length(Train{i})
%               if(i == 1)
%                 TrainSet = Train{1}{j};
%                 %TestSet = Test{1}{j};
%               end
%               TrainSet = vertcat(TrainSet,Train{i}{j});
%               %TestSet = vertcat(TestSet,Test{i}{j});
%           end
%  end
%  
%       TrainClasses = TrainSet(:,end);
%       TrainSet(:,end) = [];
%       myClassifier = ClassificationTree.fit(TrainSet, TrainClasses);
%  
%  for k =1:RowsToDel-1 
%     TestSet = Test{1}{k};
%      for l=2:length(Test)
%           TestSet = vertcat(TestSet,Test{l}{k});
%      end
%      
% 
%       TestClasses = TestSet(:,end);
%       TestSet(:,end) = [];
%         
%       res = myClassifier.predict(TestSet);  
%       ConfusionMatrix = CalcConf(res,TestClasses);  
%       [TPR,FPR,TP,FP,FN,TN] = CalcTRPFPR(ConfusionMatrix);
%        
%       All{k,1} = TPR;
%       All{k,2} = FPR;
%       All{k,3} = TP;
%       All{k,4} = FP;
%       All{k,5} = FN;
%       All{k,6} = TN;
%       All{k,7} = ConfusionMatrix;
% end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% all vs. 1 Train and  Calssify 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 vs. all Train and  Calssify

% for i =1:length(Test)
%           for j =1:length(Test{i})
%               if(i == 1)
%                 %TrainSet = Train{1}{j};
%                 TestSet = Test{1}{j};
%               end
%               %TrainSet = vertcat(TrainSet,Train{i}{j});
%               TestSet = vertcat(TestSet,Test{i}{j});
%           end
% end
%  
%       TestClasses = TestSet(:,end);
%       TestSet(:,end) = []; 
% 
% 
%  
%  for k =1:RowsToDel-1 
%     TrainSet = Train{1}{k};
%      for l=2:length(Train)
%           TrainSet = vertcat(TrainSet,Train{l}{k});
%      end
%      
% 
%       TrainClasses = TrainSet(:,end);
%       TrainSet(:,end) = [];
%       myClassifier = ClassificationTree.fit(TrainSet, TrainClasses);
%         
%       res = myClassifier.predict(TestSet);  
%       ConfusionMatrix = CalcConf(res,TestClasses);  
%       [TPR,FPR,TP,FP,FN,TN] = CalcTRPFPR(ConfusionMatrix);
%        
%       All{k,1} = TPR;
%       All{k,2} = FPR;
%       All{k,3} = TP;
%       All{k,4} = FP;
%       All{k,5} = FN;
%       All{k,6} = TN;
%       All{k,7} = ConfusionMatrix;
% end
% 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1 vs. all Train and  Calssify

end

