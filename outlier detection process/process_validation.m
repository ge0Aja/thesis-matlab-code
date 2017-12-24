clear Results_Decisions
best_params = best_params2;
for c = 1 : 8
    for i = 1 : 8 
           temp = group_vote_counts_test{c}(test_zeros(:,32) == i,:);
             if(i == c)
                temp_yfit = yfit_unknown_test{c};
                tteemmpp1 = test_zeros(test_zeros(:,32) == c,:);
             else
                 tteemmpp1 = test_zeros(test_zeros(:,32) ~= c,:);
                 tteemmpp2 = (tteemmpp1(:,32) == i);
                 temp_yfit = yfit_known_test{c}(tteemmpp2);
             end
             temp = horzcat(temp,tteemmpp1(tteemmpp1(:,32) == i,31));
             temp = horzcat(temp,temp_yfit);
             unique_flows = unique(temp(:,9));
             f_special = @(x) sum(temp(:,9) == x);
             unique_flows_counts =  arrayfun(f_special,unique_flows);
             unique_flows_stats_eff = unique_flows(unique_flows_counts > best_params.min_flow_length); %params.min_flow_length
             unique_flows_counts = unique_flows_counts( unique_flows_counts > best_params.min_flow_length); %params.min_flow_length
             for j =  1 : size(unique_flows_stats_eff,1)
%                  if(i == 2 & c == 6)
%                      oo = 0 ;
%                  end
                 unique_flow = temp(temp(:,9) == unique_flows_stats_eff(j),:);
                 w = best_params.w;% params.w;
                 alpha = best_params.alpha ;% params.alpha;
                 lambda_i_j_history = best_params.lambda_i_j_history;% params.lambda_i_j_history;
                 lambda_i_j_future = best_params.lambda_i_j_future;% params.lambda_i_j_future;
                 sample_class_index = zeros(1,unique_flows_counts(j));
                 high_confidence_samples_ind = zeros(1,unique_flows_counts(j));
                 low_confidence_samples_ind = zeros(1,unique_flows_counts(j));
                 temp_decision = zeros(unique_flows_counts(j),8);
                 
                 for k = 1: unique_flows_counts(j)

                    temp_decision(k,:) =  (unique_flow(k,1:8) >= (mean_mean_acc - mean_std_acc));
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
                                temp_decision_future = zeros(temp_w_future-k,8);
                                counter = 1;
                                for l = k+1  : temp_w_future
                                    temp_decision_future(counter,:) = (unique_flow(l,1:8) >= (mean_mean_acc - mean_std_acc));
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

%                         else
%                             ratio_high_confidence_samples_history_long = sum(high_confidence_samples_ind(1:k - temp_w)) ./ (k - temp_w -1);
%                             ratio_low_confidence_samples_history_long = sum(low_confidence_samples_ind(1:k - temp_w)) ./ (k - temp_w -1);
%                             
%                             ratio_high_confidence_samples_history_short = sum(high_confidence_samples_ind(k - temp_w:k)) ./ temp_w;
%                             ratio_low_confidence_samples_history_short = sum(low_confidence_samples_ind(k - temp_w:k)) ./ temp_w;
%                             
%                             Risk_u_history = lambda_i_j_history * ( ((1 - beta)  * ratio_high_confidence_samples_history_long ) + ...
%                                 (beta  * ratio_high_confidence_samples_history_short ));
%                             
%                             Risk_k_history = (1 - lambda_i_j_history) * ( ((1 - beta)  * ratio_low_confidence_samples_history_long ) + ...
%                                 (beta  * ratio_low_confidence_samples_history_short ));
%                         end
                        % simulate that you are getting samples from the
                        % future of the flow and calculate the future ratio
                        if(k <= unique_flows_counts(j))
                            if(k+w <= unique_flows_counts(j))
                                temp_w_future = k+w;
                            else
                                temp_w_future = k+(unique_flows_counts(j) - k);
                            end
                            temp_high_confidence_samples_ind = zeros(1,temp_w_future-k);
                            temp_low_confidence_samples_ind = zeros(1,temp_w_future-k);
                            temp_sample_class_index = zeros(1,temp_w_future-k);
                            temp_decision_future = zeros(temp_w_future-k,8);
                            counter = 1;
                            for l = k+1  : temp_w_future
                                temp_decision_future(counter,:) = (unique_flow(l,1:8) >= (mean_mean_acc - mean_std_acc));
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
                            
                            if(temp_most_appearing_class_ratios(top_ratio) > best_params.confidence_ratio) % params.confidence_ratio
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
                 Results_Decisions{c}{i}{j} = sample_class_index';
             end
    end
end

for i = 1 : 8 
    for j = 1 : 8
        ttpp2 = size(cat(1,Results_Decisions{i}{j}{:}),1);
        if(i ~= j)
           
           ttoo2 = sum(cat(1,Results_Decisions{i}{j}{:}) == 0);   
           ttoo3 = sum(cat(1,Results_Decisions{i}{j}{:}) == j);

           tq2(i,j) = ttoo2 ./ ttpp2;
           tq3(i,j) = ttoo3 ./ ttpp2;
        else
            ttoo1 = sum(cat(1,Results_Decisions{i}{j}{:}) ~= 0);
            ttoo = sum(cat(1,Results_Decisions{i}{j}{:}) == 0);
            tq(i) = ttoo ./ ttpp2;
            tq1(i) = ttoo1 ./ ttpp2;
        end
    end  
end

for i = 1 : 8
    temp_mean  =mean(tq2([1:8] ~= i,:));
    mean_mean_fpr(i) = temp_mean(i);
end

temp_mean = [] ;
for i = 1 : 8
    temp_mean  =mean(tq3([1:8] ~= i,:));
    mean_mean_tpr(i) = temp_mean(i);
end

