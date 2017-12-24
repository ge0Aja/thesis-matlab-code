function [ reported_objective,reported_error ] = Bayes_processFopt_single_user( train,test,validate,Label,best_params,wanted_error )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
tic
for c = 1 : 1
[ group_vote_counts_test,new_test_data,mean_mean_acc,mean_std_acc ,yfit_unknown_test,yfit_known_test,test_counts,validate_counts,train_counts,~] = Bayes_process_inner_single_user(train,test,validate,Label,best_params.prct,best_params.learners,best_params.predictors,best_params.min_leaf);

%  if(any(test_counts == 0)  || any(validate_counts == 0) || any(train_counts == 0) )
%     reported_objective = 1;
%     reported_error = 1 ;
%     fprintf('invalid data from inside \n')
%     return
%  end
%% Bayes
          for cc = 1 : length(Label)% length(New_Labels)
            for i = 1 : length(Label)% length(New_Labels)
                   temp = group_vote_counts_test{cc}(new_test_data(:,32) == Label(i),:);
                   if(~isempty(temp))
                     if(Label(i) == Label(cc))
                        temp_yfit = yfit_unknown_test{cc};
                        tteemmpp1 = new_test_data(new_test_data(:,32) == Label(cc),:);
                     else
                         tteemmpp1 = new_test_data(new_test_data(:,32) ~= Label(cc),:);
                         tteemmpp2 = (tteemmpp1(:,32) == Label(i));
                         temp_yfit = yfit_known_test{cc}(tteemmpp2);
                     end
                     temp = horzcat(temp,tteemmpp1(tteemmpp1(:,32) == Label(i),31));
                     temp = horzcat(temp,temp_yfit);
                     unique_flows = unique(temp(:,length(Label) + 1 ));
                     f_special = @(x) sum(temp(:,length(Label) + 1) == x);
                     unique_flows_counts =  arrayfun(f_special,unique_flows);
                     unique_flows_stats_eff = unique_flows(unique_flows_counts >= best_params.min_flow_length); %params.min_flow_length
                     unique_flows_counts = unique_flows_counts( unique_flows_counts >= best_params.min_flow_length); %params.min_flow_length
                     for j =  1 : size(unique_flows_stats_eff,1)
                         if(i == 2)
                             oo = 0 ;
                         end
                         unique_flow = temp(temp(:,length(Label) + 1) == unique_flows_stats_eff(j),:);
                         w = best_params.w;% ;
                         alpha = best_params.alpha ;% ;
                         lambda_i_j_history = best_params.lambda_i_j_history;% ;
                         lambda_i_j_future = best_params.lambda_i_j_future;% ;
                         sample_class_index = zeros(1,unique_flows_counts(j));
                         high_confidence_samples_ind = zeros(1,unique_flows_counts(j));
                         low_confidence_samples_ind = zeros(1,unique_flows_counts(j));
                         temp_decision = zeros(unique_flows_counts(j),length(Label));
                         temp_dzscore= zeros(unique_flows_counts(j),length(Label));
                         temp_pvalues = zeros(unique_flows_counts(j),length(Label));
                         for k = 1: unique_flows_counts(j)
                            % add the logic here for baysian risk 
                            temp_dzscore(k,:) = (unique_flow(k,1:length(Label)) - mean_mean_acc) ./ mean_std_acc;
                            temp_pvalues(k,:) = normcdf(temp_dzscore(k,:),0,1); %2 .* normcdf(-abs(temp_dzscore(k,:)),0,1);
%                             temp_decision(k,:) =  (unique_flow(k,1:length(Label)) >= (mean_mean_acc - mean_std_acc));
                            temp_decision(k,:) =  (temp_pvalues(k,:) > best_params.pval_threshold);
                            if(sum(temp_decision(k,:))  == 1)
                                % we have to test if the high confidence sample is
                                % the manjority.
                                if(k == 1)
                                   high_confidence_samples_ind(k) = 1;
                                   low_confidence_samples_ind(k) = 0;
                                   sample_class_index(k) = find(temp_decision(k,:),1);
                                end
                                if(k ~= 1)
                                    decision_index = find(temp_decision(k,:),1);
                                    sample_class_index(k) = decision_index;
                                    if(k <= w)
                                        temp_w = max(k-1,1);
                                    else
                                        temp_w = w;
                                    end

                                    % caculate the ratios for samples in the history of
                                    % the flow consider short and long history and caculate risks of the history
                                    ratio_high_confidence_samples_history_long = sum(sample_class_index(1:k) == decision_index) ./ k;
                                    ratio_low_confidence_samples_history_long = sum(sample_class_index(1:k) ~= decision_index) ./ k;

                                    Risk_u_history = lambda_i_j_history * ratio_high_confidence_samples_history_long; % lambda_i_j_history *
                                    Risk_k_history = (1- lambda_i_j_history) * ratio_low_confidence_samples_history_long; % (1- lambda_i_j_history) * I think classifying known should have more risk
                                    % start future 
                                     if(k < unique_flows_counts(j))
                                        if(k+w <= unique_flows_counts(j))
                                            temp_w_future = k+w;
                                        else
                                            temp_w_future = k+(unique_flows_counts(j) - k);
                                        end
                                        temp_high_confidence_samples_ind = zeros(1,temp_w_future-k);
                                        temp_low_confidence_samples_ind = zeros(1,temp_w_future-k);
                                        temp_decision_future = zeros(temp_w_future-k,length(Label));
                                        temp_dzscore_fututre= zeros(temp_w_future-k,length(Label));
                                        temp_pvalues_fututre = zeros(temp_w_future-k,length(Label));
                                        counter = 1;
                                        for l = k+1  : temp_w_future
                                            temp_dzscore_fututre(counter,:) = (unique_flow(l,Label) - mean_mean_acc) ./ mean_std_acc;
                                            temp_pvalues_fututre(counter,:) = normcdf(temp_dzscore_fututre(counter,:),0,1);%2 .* normcdf(-abs(temp_dzscore(l,:)),0,1);
%                                             temp_decision_future(counter,:) = (unique_flow(l,1:length(Label)) >= (mean_mean_acc - mean_std_acc));
                                            temp_decision_future(counter,:) = (temp_pvalues_fututre(counter,:) > best_params.pval_threshold);
                                             if(sum(temp_decision_future(counter,:))  == 1 && (find(temp_decision_future(counter,:),1) == decision_index))
                                               temp_high_confidence_samples_ind(counter) = 1;
                                               temp_low_confidence_samples_ind(counter) = 0;
                                             else
                                                 %I have to add an if else here to
                                                 %include the cases that it is not
                                                 %within mean-std but it is mostly
                                                 %t
                                                temp_high_confidence_samples_ind(counter) = 0;
                                                temp_low_confidence_samples_ind(counter) = 1;
                                             end
                                            counter = counter +1;
                                        end
                                        ratio_high_confidence_samples_future_window = sum(temp_high_confidence_samples_ind) ./ (temp_w_future-k);%temp_w_future;
                                        ratio_low_confidence_samples_future_window = sum(temp_low_confidence_samples_ind) ./ (temp_w_future-k);%temp_w_future;
                                        %caculate risks of the future
                                        Risk_u_future = lambda_i_j_future * ratio_high_confidence_samples_future_window; % lambda_i_j_future * 
                                        Risk_k_future = (1- lambda_i_j_future) * ratio_low_confidence_samples_future_window; % (1- lambda_i_j_future) *

                                        %calculate total risk 

                                        Risk_u_total = ((1- alpha) *  Risk_u_history) + alpha * Risk_u_future;
                                        Risk_k_total = ((1- alpha) *  Risk_k_history) + alpha * Risk_k_future;
                                    else
                                        Risk_u_total = (1- alpha) * Risk_u_history;
                                        Risk_k_total = alpha * Risk_k_history;
                                    end

                                    if(Risk_u_total > Risk_k_total)
                                        sample_class_index(k) = decision_index;
                                        high_confidence_samples_ind(k) = 1;
                                    else
                                        sample_class_index(k) = 0;
                                    end
                                end 
                            end

                            if(sum(temp_decision(k,:))  == 0)
                                high_confidence_samples_ind(k) = 0;
                                low_confidence_samples_ind(k) = 1;

                                if(k <= w)
                                    temp_w = max(k-1,1);
                                else
                                    temp_w = w;
                                end

                                % caculate the ratios for samples in the history of
                                % the flow consider short and long history and caculate risks of the history
                                ratio_high_confidence_samples_history_long = sum(high_confidence_samples_ind(1:k)) ./ k;
                                ratio_low_confidence_samples_history_long = sum(low_confidence_samples_ind(1:k)) ./ k;

                                Risk_u_history = lambda_i_j_history * ratio_high_confidence_samples_history_long; % 
                                Risk_k_history = (1- lambda_i_j_history) * ratio_low_confidence_samples_history_long;% 

                                if(k <= unique_flows_counts(j))
                                    if(k+w <= unique_flows_counts(j))
                                        temp_w_future = k+w;
                                    else
                                        temp_w_future = k+(unique_flows_counts(j) - k);
                                    end
                                    temp_high_confidence_samples_ind = zeros(1,temp_w_future-k);
                                    temp_low_confidence_samples_ind = zeros(1,temp_w_future-k);
                                    temp_sample_class_index = zeros(1,temp_w_future-k);
                                    temp_decision_future = zeros(temp_w_future-k,length(Label));
                              
                                    temp_dzscore_future= zeros(temp_w_future-k,length(Label));
                                    temp_pvalues_future = zeros(temp_w_future-k,length(Label));
                                    counter = 1;
                                    for l = k+1  : temp_w_future
                                         temp_dzscore_future(counter,:) = (unique_flow(l,Label) - mean_mean_acc) ./ mean_std_acc;
                                         temp_pvalues_future(counter,:) = normcdf(temp_dzscore_future(counter,:),0,1);%2 .* normcdf(-abs(temp_dzscore(l,:)),0,1);
%                                             temp_decision_future(counter,:) = (unique_flow(l,1:length(Label)) >= (mean_mean_acc - mean_std_acc));
                                         temp_decision_future(counter,:) = (temp_pvalues_future(counter,:) > best_params.pval_threshold);
                                        if(sum(temp_decision_future(counter,:))  == 1)
                                           temp_high_confidence_samples_ind(counter) = 1;
                                           temp_low_confidence_samples_ind(counter) = 0;
                                           temp_sample_class_index(counter,:) = find(temp_decision_future(counter,:),1);
                                         end
                                        if(sum(temp_decision_future(counter,:))  == 0)
                                            temp_high_confidence_samples_ind(counter) = 0;
                                            temp_low_confidence_samples_ind(counter) = 1;
                                        end
                                        counter = counter +1;
                                    end
                                    ratio_high_confidence_samples_future_window = sum(temp_high_confidence_samples_ind) ./ (temp_w_future -k) ;
                                    ratio_low_confidence_samples_future_window = sum(temp_low_confidence_samples_ind) ./ (temp_w_future -k) ;
                                    %caculate risks of the future
                                    Risk_u_future = lambda_i_j_future *  ratio_high_confidence_samples_future_window; 
                                    Risk_k_future = (1- lambda_i_j_future) *  ratio_low_confidence_samples_future_window; 
                                    %calculate total risk 
                                    Risk_u_total = ((1- alpha) *  Risk_u_history) + alpha * Risk_u_future;
                                    Risk_k_total = ((1- alpha) *  Risk_k_history) + alpha * Risk_k_future;
                                else
                                    Risk_u_total = (1- alpha) * Risk_u_history;
                                    Risk_k_total = alpha * Risk_k_history;
                                end

                                if(Risk_u_total > Risk_k_total)
                                    % we have to figure out a solution for
                                    % multiclass samples in the same flow which can
                                    % be considered as an ambiguity therefore we
                                    % have to test
                                    temp_sum_classes_now = sum(temp_decision,1);
                                    temp_sum_classes_future = sum(temp_decision_future,1);

                                    temp_most_appearing_class = (temp_sum_classes_now + temp_sum_classes_future);
                                    temp_most_appearing_class_ratios = temp_most_appearing_class ./ sum(temp_most_appearing_class);

        %                             sample_class_index(k) = find (temp_most_appearing_class == max(temp_most_appearing_class),1);
                                    top_ratio = find(temp_most_appearing_class_ratios == max(temp_most_appearing_class_ratios),1);

                                    if(temp_most_appearing_class_ratios(top_ratio) > best_params.confidence_ratio) % 
                                        sample_class_index(k) = top_ratio;
                                    else
                                        sample_class_index(k) = 0;
                                    end
                                else
                                    % let it zero as unknown
                                    sample_class_index(k) = 0;
                                end
                            end
                         end
                         Results_Decisions{c}{cc}{i}{j} = sample_class_index';
                     end
                 end
            end
        end
end
toc

for c = 1 : 1
for i = 1 : length(Label)
   if(~isempty(Results_Decisions{c}{i}))
        for j = 1 : length(Label)
            if(~isempty(Results_Decisions{c}{i}{j}))
                ttpp2 = size(cat(1,Results_Decisions{c}{i}{j}{:}),1);
                if(i ~= j) 
                   FP = sum(cat(1,Results_Decisions{c}{i}{j}{:}) == 0);   
                   TN = sum(cat(1,Results_Decisions{c}{i}{j}{:}) == j);
                   tq2(i,j) = FP ./ ttpp2;
                   tq3(i,j) = TN ./ ttpp2;
                else
                    FN = sum(cat(1,Results_Decisions{c}{i}{j}{:}) ~= 0);
                    TP = sum(cat(1,Results_Decisions{c}{i}{j}{:}) == 0);
                    tq(i) = TP ./ ttpp2;
                    tq1(i) = FN ./ ttpp2;
                end
            end
        end
   end
end
    eval_res_tq(c,:) = tq;
    eval_res_tq1(c,:) = tq1;
    eval_res{c}{1} = tq2;
    eval_res{c}{2} = tq3;
end

for c = 1 : 1
    for i = 1 : length(Label)
    temp_mean(c,:)  =mean(eval_res{c}{1}(Label ~= Label(i),:));
%     mean_mean_fpr(i) = temp_mean(i);
    end
end
   mean_mean_temp_mean = mean(temp_mean);
   mean_mean_fpr = mean_mean_temp_mean;
   
%    reported_error =  mean_mean_fpr  - wanted_error ;
   
   mean_mean_eval_res_tq = mean(eval_res_tq);
   mean_mean_tpr = mean(mean_mean_eval_res_tq);
   
%    reported_objective =  1- mean_mean_tpr;
    reported_objective = mean_mean_fpr;
    reported_error = (1- mean_mean_tpr)  - wanted_error ;
end

