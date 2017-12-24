
maxMinLS = 20;
minLS = optimizableVariable('minLS',[1,maxMinLS],'Type','integer');
Predictors = optimizableVariable('Predictors',[1,28],'Type','integer');
Trees = optimizableVariable('Trees',[30,300],'Type','integer');
hyperparametersRF = [Trees;minLS;Predictors];
% parfor i = 1 : 9
% results = bayesopt(@(params)oobErrRFTweak(params,Merged_Dataset{1}{1},Merged_Dataset{1}{2}),hyperparametersRF,...
% 'AcquisitionFunctionName','expected-improvement-plus','Verbose',0);
% % end


results_kfold = bayesopt(@(params)optimizeKFold(Data_Sets,game_321_2_2,Label,params),hyperparametersRF,...
'AcquisitionFunctionName','expected-improvement-plus','Verbose',0);
%

% results{i} = bayesopt(@(params)oobErrRF(params,Data_Sets22{i}{1},Data_Sets22{i}{3}),hyperparametersRF,...
% 'AcquisitionFunctionName','expected-improvement-plus','Verbose',0);
% 
% 
