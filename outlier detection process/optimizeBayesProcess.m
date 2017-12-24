clear results
rng('default')
% min_flow_length = optimizableVariable('min_flow_length',[1,10],'Type','integer');
% w = optimizableVariable('w',[2,10],'Type','integer');
% flow_prob = optimizableVariable('flow_prob',[0.5,1.0],'Type','real');
% lambda_i_j = optimizableVariable('lambda_i_j',[0.2,0.7],'Type','real');
% hyperparametersBayes= [min_flow_length;w;flow_prob;lambda_i_j];

min_flow_length = optimizableVariable('min_flow_length',[1,15],'Type','integer');
w = optimizableVariable('w',[1,20],'Type','integer');
alpha = optimizableVariable('alpha',[0,0.5],'Type','real');
lambda_i_j_history = optimizableVariable('lambda_i_j_history',[0.5,1],'Type','real'); 
lambda_i_j_future = optimizableVariable('lambda_i_j_future',[0.5,1],'Type','real'); 
confidence_ratio = optimizableVariable('confidence_ratio',[0.7,1],'Type','real');
hyperparametersBayes= [min_flow_length;w;alpha;lambda_i_j_history;lambda_i_j_future;confidence_ratio];
%   parfor i = 1 : 30



results_err_02 = bayesopt(@(params)Process_error(params,group_vote_counts_test,yfit_unknown_test,yfit_known_test,test_zeros,mean_mean_acc,mean_std_acc,0.05),...
hyperparametersBayes,'NumCoupledConstraints',1,'PlotFcn',...
{@plotMinObjective,@plotConstraintModels},...
'AcquisitionFunctionName','expected-improvement-plus','Verbose',0);

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