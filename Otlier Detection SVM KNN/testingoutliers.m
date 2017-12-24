tic
ind = [1 2 3 4 5 6 7 8 9];
classind = [1 2 3 4 5 6];
outlier = [];
outliersnap = [];
pointoutlierscore = [];
paroptions = statset('UseParallel',true);
parfor i = 1:9
%     ind = (newdata(:,end) == i);
%     trainind = ~ind;
%     
% train = [];
% test = [];
train = DataSets{i}{1};
test = DataSets{i}{2};
%     for q = 1 : 9
%         if(q == i)
%             %take all test samples
% %             ctest = randperm(length(All5{q}),313);
%             test = All5{q};%(ctest,:);
%         else
%             train = vertcat(train,All5{q});
%         end
%     end
    B = TreeBagger(200,train(:,1:28),...
        train(:,end),...
        'OOBPredictorImportance','On',...
        'Method','classification',...
        'NumPredictorsToSample','all',...
        'MinLeafSize',2,...
        'Options',paroptions);
    fprintf('Created BaggedTrees for %d',i);
    
    [res score] = predict(B,test(:,1:28));
    mat = cell2mat(res);
    prd= str2num(mat);
    fprintf('Predicted using BaggedTrees for Test %d',i);
%     conf = confusionmat(test(:,end),prd);
%     [TPR(i,:),FPR(i,:),F1(i,:)] = CalcTRPFPR(conf);
%     prox = proximity(B.compact,shuffled(:,[false false false true true false false false false false false true false false false true false false false false false false false true false false false false false]));
%     fprintf('Calculated proximity for Test %d',i);

% tic
 [finaloutlierscoresnap{i}, finaloutlierscoretest{i}] = Calcpointoutliermeasure(B,test,snap);
%  finaloutlierscoretest(i,:) = outlierMeasure(B.compact,test(:,1:28));
% toc
% for t =1:length(snap)
% classoutlier = [];
%     for p = 1 : 6
%         % We should decrease the number of used points in outlier
%         % calculation to take class representitives 
%         outlierclasssamples = test((test(:,end)==classind(p)),1:28);
%         zingi = outlierMeasure(B.compact,vertcat(snap(t,1:28),outlierclasssamples(randperm(length(outlierclasssamples),30),1:28)));
%         classoutlier = horzcat(classoutlier,zingi(1,1));
%     end
%     pointoutlierscore = vertcat(pointoutlierscore,classoutlier);
% %     outlier(i,:) = outlierMeasure(B.compact,test(:,1:28));
% %     outliersnap(i,:) = outlierMeasure(B.compact,snap(:,1:28));
% %     fprintf('Calculated Outliers for Test %d',i);
% end
end

toc
% 
% [res,score,] = predict(trainedClassifier,shuffled(:,[false false false true true false false false false false false true false false false true false false false false false false false true false false false false false]));
% Correctoutlier = outlierMeasure(B.compact,shuffled(CorrectlyClassifiedInd,[false false false true true false false false false false false true false false false true false false false false false false false true false false false false false]));
%     
% AnonCorrectoutlier = outlierMeasure(B.compact,matt(:,[false false false true true false false false false false false true false false false true false false false false false false false true false false false false false]));
% MisCorrectoutlier = outlierMeasure(B.compact,shuffled(~CorrectlyClassifiedInd,[false false false true true false false false false false false true false false false true false false false false false false false true false false false false false]));