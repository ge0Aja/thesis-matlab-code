rng('shuffle')

maxMinLS = 5;
minLS = optimizableVariable('min_leaf',[1,maxMinLS],'Type','integer');
Predictors = optimizableVariable('predictors',[1,28],'Type','integer');
Learners = optimizableVariable('learners',[30,50],'Type','integer');
Test_Data_Percentage = optimizableVariable('prct',[10,15],'Type','integer');
pval_threshold = optimizableVariable('pval_threshold',[0.33,0.8]);
min_flow_length = optimizableVariable('min_flow_length',[1,10],'Type','integer');
w = optimizableVariable('w',[1,10],'Type','integer');
alpha = optimizableVariable('alpha',[0,0.5],'Type','real');
lambda_i_j_history = optimizableVariable('lambda_i_j_history',[0.5,1],'Type','real'); 
lambda_i_j_future = optimizableVariable('lambda_i_j_future',[0.5,1],'Type','real'); 
confidence_ratio = optimizableVariable('confidence_ratio',[0.5,1],'Type','real');
hyperparametersBayes= [minLS;Predictors;Test_Data_Percentage;Learners;min_flow_length;w;alpha;lambda_i_j_history;lambda_i_j_future;confidence_ratio;pval_threshold];
%   parfor i = 1 : 30

 parfor i = 1 : 10
    results_bayes_single_user{i} = bayesopt(@(params)Bayes_processFopt_single_user(train,test,validate,Labels,params,0.10),...
    hyperparametersBayes,'NumCoupledConstraints',1,'PlotFcn',...
    {@plotMinObjective,@plotConstraintModels},...
    'AcquisitionFunctionName','expected-improvement-plus','Verbose',0);
 end

%  best_params = results_bayes.XAtMinObjective;
%  save('reslts_opt_single_user2.mat','results_bayes')
%   end
% clear valid_res


% parfor i = 1 : 8
%     best_params = results{i}.XAtMinObjective;
%  valid_res{i} = optimizeBayes(best_params,group_vote_counts,test_zeros,yfit_unknown,yfit_known,mean_mean_acc,std_mean_acc,0.05);
% end

% parfor i = 1 : 10
%     best_params = results_err_01{i}.XAtMinObjective;
%     respppp{i} = process_opt_res (best_params,group_vote_counts_test,yfit_unknown_test,yfit_known_test,test_zeros,mean_mean_acc,mean_std_acc );
% end