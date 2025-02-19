function [trainedClassifier, resubstitutionAccuracy] = trainClassifierBaggedTree(datasetTable)
% Convert input to table
datasetTable = table(datasetTable);
datasetTable.Properties.VariableNames = {'column'};
% Split matrices in the input table into vectors
datasetTable.column_1 = datasetTable.column(:,1);
datasetTable.column_2 = datasetTable.column(:,2);
datasetTable.column_3 = datasetTable.column(:,3);
datasetTable.column_4 = datasetTable.column(:,4);
datasetTable.column_5 = datasetTable.column(:,5);
datasetTable.column_6 = datasetTable.column(:,6);
datasetTable.column_7 = datasetTable.column(:,7);
datasetTable.column_8 = datasetTable.column(:,8);
datasetTable.column_9 = datasetTable.column(:,9);
datasetTable.column_10 = datasetTable.column(:,10);
datasetTable.column_11 = datasetTable.column(:,11);
datasetTable.column_12 = datasetTable.column(:,12);
datasetTable.column_13 = datasetTable.column(:,13);
datasetTable.column_14 = datasetTable.column(:,14);
datasetTable.column_15 = datasetTable.column(:,15);
datasetTable.column_16 = datasetTable.column(:,16);
datasetTable.column_17 = datasetTable.column(:,17);
datasetTable.column_18 = datasetTable.column(:,18);
datasetTable.column_19 = datasetTable.column(:,19);
datasetTable.column_20 = datasetTable.column(:,20);
datasetTable.column_21 = datasetTable.column(:,21);
datasetTable.column_22 = datasetTable.column(:,22);
datasetTable.column_23 = datasetTable.column(:,23);
datasetTable.column_24 = datasetTable.column(:,24);
datasetTable.column_25 = datasetTable.column(:,25);
datasetTable.column_26 = datasetTable.column(:,26);
datasetTable.column_27 = datasetTable.column(:,27);
datasetTable.column_28 = datasetTable.column(:,28);
datasetTable.column_29 = datasetTable.column(:,29);
datasetTable.column = [];
% Extract predictors and response
predictorNames = {'column_1', 'column_2', 'column_3', 'column_4', 'column_5', 'column_6', 'column_7', 'column_8', 'column_9', 'column_10', 'column_11', 'column_12', 'column_13', 'column_14', 'column_15', 'column_16', 'column_17', 'column_18', 'column_19', 'column_20', 'column_21', 'column_22', 'column_23', 'column_24', 'column_25', 'column_26', 'column_27', 'column_28'};
predictors = datasetTable(:,predictorNames);
predictors = table2array(varfun(@double, predictors));
response = datasetTable.column_29;
% Data transformation: Select subset of the features
predictors = predictors(:,[true true false true true false false false false false false true false true false true false false false false true false true false true false false false]);
% Train a classifier
trainedClassifier = fitensemble(predictors, response, 'Bag', 200, 'Tree', 'Type', 'Classification', 'PredictorNames', {'column_1' 'column_2' 'column_4' 'column_5' 'column_12' 'column_14' 'column_16' 'column_21' 'column_23' 'column_25'}, 'ResponseName', 'column_29', 'ClassNames', [1 2 3 4 5 6]);

% Compute resubstitution accuracy
resubstitutionAccuracy = 1 - resubLoss(trainedClassifier, 'LossFun', 'ClassifError');

%% Uncomment this section to compute resubstitution predictions and scores:
% % Compute resubstitution predictions and scores
% [resubstitutionPredictions, resubstitutionScores] = predict(trainedClassifier, predictors);