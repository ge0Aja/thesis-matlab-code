tic
clear Results_Decisions
for c = 1 : 9
    train = Data_Sets22{c}{1};
    test = Data_Sets22{c}{2};
    validate = Data_Sets22{c}{3};
    
    tf_test = @(x) sum(test(:,32) == x);
    tf_train = @(x) sum(train(:,32) == x);
    tf_validate = @(x) sum(validate(:,32) == x);

    train_counts = arrayfun(tf_train,unique(train(:,32)));
    test_counts = arrayfun(tf_test,unique(test(:,32)));
    validate_counts = arrayfun(tf_validate,unique(validate(:,32)));
    
    if (c == 3)
        test_counts = [0;test_counts];
    end
    
    
    min_count_exp_w = min(train_counts([1:length(Label)] ~= 2 )); % & [1:6] ~= l
    
    new_train_data_balanced = [];
    
     for i = 1 : length(Label)
            temp = train(train(:,32) == Label(i),:);
            if(i ~= 2)
            if(~isempty(temp))
                 new_train_data_balanced = vertcat(new_train_data_balanced, temp(randperm(train_counts(i),min_count_exp_w),:));
            end
            else
                new_train_data_balanced = vertcat(new_train_data_balanced, temp(randperm(train_counts(i),train_counts(i)),:));
            end
     end


        tf_train_balanced = @(x) sum(new_train_data_balanced(:,32) == x);
        train_balanced_counts  = arrayfun(tf_train_balanced,unique(new_train_data_balanced(:,32)));
        
        
        new_test_data_balanced_10 = [];
        for i = 1 : length(Label)
            temp = test(test(:,32) == Label(i),:);
            if(~isempty(temp))
            temp_test_samples_count = round(train_balanced_counts(i).* 0.2);
            if(temp_test_samples_count > test_counts(i))
                temp_test_samples_count = test_counts(i);
            end
            new_test_data_balanced_10 = vertcat(new_test_data_balanced_10,temp(randperm(test_counts(i),temp_test_samples_count),:));
            end
        end
        
        new_validate_data_balanced_10 = [];
        for i = 1 : length(Label)
            temp = validate(validate(:,32) == Label(i),:);
            if(~isempty(temp))
            temp_validate_samples_count = round(train_balanced_counts(i).* 0.2);
            if(temp_validate_samples_count > validate_counts(i))
                temp_validate_samples_count = validate_counts(i);
            end
            new_validate_data_balanced_10 = vertcat(new_validate_data_balanced_10,temp(randperm(validate_counts(i),temp_validate_samples_count),:));
            end
        end
        
        
             new_test_data_balanced_10(new_test_data_balanced_10(:,32) == 2,:) = [] ;
             new_train_data_balanced(new_train_data_balanced(:,32) == 2,:) = [] ;
             new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == 2,:) = [] ;

            new_train_data_balanced(isnan(new_train_data_balanced)) = 0 ;
            new_train_data_balanced(isinf(new_train_data_balanced)) = 0 ;

            new_test_data_balanced_10(isnan(new_test_data_balanced_10)) = 0 ;
            new_test_data_balanced_10(isinf(new_test_data_balanced_10)) = 0 ;
            
            new_validate_data_balanced_10(isnan(new_validate_data_balanced_10)) = 0 ;
            new_validate_data_balanced_10(isinf(new_validate_data_balanced_10)) = 0 ; 
            
            
            [~,val] = getTrain_Test( Game_G,1,[2]); %Game_long
            [tr,te] = getTrain_Test( Game_G,1,[2]); %Game_long
            
            tr(tr(:,1) < 20 & tr(:,2) < 20 & tr(:,32) == 2,:) = [];
            te(te(:,1) < 20 & te(:,2) < 20 & te(:,32) == 2,:) = [];
            val(val(:,1) < 20 & val(:,2) < 20 & val(:,32) == 2,:) = [];
           
            
            new_train_data_balanced = vertcat(new_train_data_balanced,tr);
            new_test_data_balanced_10 = vertcat(new_test_data_balanced_10,te);
            new_validate_data_balanced_10 = vertcat(new_validate_data_balanced_10,val);
            
%             new_test_data_balanced_10(new_test_data_balanced_10(:,32) == 2 & new_test_data_balanced_10(:,2) < 2,:) = [] ;
%             new_train_data_balanced(new_train_data_balanced(:,32) == 2 & new_train_data_balanced(:,2) < 2,:) = [] ;
%             new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == 2 & new_validate_data_balanced_10(:,2) < 2,:) = [] ;

%             trainedClassifier8Users = trainClassifierBagged28Features(new_train_data_balanced);
        clear Classifier
            for l = 1 : length(Label)
                [Classifier{c}{l},] = parRandForesttest( new_train_data_balanced(new_train_data_balanced(:,32) ~= Label(l),:),new_validate_data_balanced_10,30,14,1);
            end     
%             clear pred_known
%             clear pred_unknown
            for l = 1 : length(Label)
                for j = 1: 30
                     pred_known{c}{l}{j}  =Classifier{c}{l}.Trees{j}.predict(new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) ~= Label(l),1:28));
                     pred_unknown{c}{l}{j}  = Classifier{c}{l}.Trees{j}.predict(new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == Label(l),1:28));
                end
            end
            
%             clear pred_mat_all
            for i = 1 : length(Label)
                pred_mat_known = [];
                pred_mat_unknown = [];
                for j = 1 : 30
                     pred_mat_known = horzcat(pred_mat_known,pred_known{c}{i}{j});
                     pred_mat_unknown =horzcat(pred_mat_unknown,pred_unknown{c}{i}{j});
                     pred_mat_all{c}{i}{1} = pred_mat_known;
                     pred_mat_all{c}{i}{2} = pred_mat_unknown;
                end
            end
            
            
            for j = 1 : length(Label)
                tteemmpp = new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) ~= Label(j),:); % test_zeros(test_zeros(:,32) ~= j,:);
                for i = 1 : length(Label)
                     temp_2 = (tteemmpp(:,32) == Label(i));
                     temp_pred_mat = [];
                      if(i == j)
                          temp_pred_mat = cellfun(@str2num,pred_mat_all{c}{j}{2});    
                      else
                         temp_pred_mat = cellfun(@str2num,pred_mat_all{c}{j}{1});
                         temp_pred_mat = temp_pred_mat(temp_2,:);
                      end
                      op_fn = @(x) sum(temp_pred_mat ==x,2);
                      vote_count_all{c}{j,i} = arrayfun(op_fn,[1:length(Label)],'UniformOutput',false);
                end
            end

            for i = 1: length(Label) 
                yfit_known{c}{i} = cellfun(@str2num,Classifier{c}{i}.predict(new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) ~= Label(i),1:28)));
                yfit_unknown{c}{i} = cellfun(@str2num,Classifier{c}{i}.predict(new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == Label(i),1:28)));
            end            
            for i = 1 : length(Label)
                for j = 1 : length(Label)
                    temp = cat(2,vote_count_all{c}{i,j}{:});
            %         tteemmpp = test_zeros(test_zeros(:,32) ~= i,:);
                     tteemmpp = new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) ~= Label(i),:);
                    if(Label(i) ~= Label(j))
            %             temp_2 = test_zeros(test_zeros(:,32) == j,32);
                        temp_2 = tteemmpp(tteemmpp(:,32) == Label(j),32);
            %             temp_yfit = yfit(test_zeros(:,32) == j,i);
                        temp_yfit = yfit_known{c}{i}((tteemmpp(:,32) == Label(j)),:);
                        ma_temp = mean(temp( temp_2 & (temp_yfit==Label(j)) ,:));
                        sa_temp = std(temp( temp_2 & (temp_yfit==Label(j)) ,:));
                        mean_accurate_class{c}(i,j) = ma_temp(j);
                        std_accurate_class{c}(i,j) = sa_temp(j);

                        mean_accurate_otherclasses{c}{i}(j,:) = ma_temp;
                        std_accurate_otherclasses{c}{i}(j,:) = sa_temp;

                        std_accurate_otherclasses{c}{i}(j,j) = NaN;
                        mean_accurate_otherclasses{c}{i}(j,j) = NaN;
                    else
                        mean_unknown{c}(i,:) = mean(temp);
                    end
                end
            end

            %% create an accumulated matrix of vote counts 
            for i = 1 : length(Label)
                temp = [];
                for j = 1 :length(Label)
                    temp = vertcat(temp,cat(2,vote_count_all{c}{i,j}{:}));
                end
                group_vote_counts{c}{i} = temp;
            end
            %% caculate mean mean stats 
            for i = 1 : length(Label)
            % mean_mean_test_f1(i) = mean(test_f1([1:8]~=i,i))
            mean_mean_acc{c}(i) = mean(mean_accurate_class{c}([1:6]~=i,i));
            % mean_mean_inacc(i) = mean(mean_inaccurate_class([1:8]~=i,i));

            mean_std_acc{c}(i) = mean(std_accurate_class{c}([1:6]~=i,i));
            % mean_std_inacc(i) = mean(mean_inaccurate_class([1:8]~=i,i));
            end
  
            %% testing using test dataset 

            for i = 1 : length(Label)
                for j = 1: 30
            %         pred{i}{j}  = Classifiers_group{i}.Trees{j}.predict(test_zeros(:,1:28));
                    pred_known_test{c}{i}{j}  =Classifier{c}{i}.Trees{j}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) ~= Label(i),1:28));
                    pred_unknown_test{c}{i}{j}  =Classifier{c}{i}.Trees{j}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Label(i),1:28));
                end
            end

            for i = 1 : length(Label)
               pred_mat_known_test = [];
               pred_mat_unknown_test = [];
                for j =1 : 30
            %         pred_mat = horzcat(pred_mat,cellfun(@str2num,pred{i}{j}));
                    pred_mat_known_test = horzcat(pred_mat_known_test,pred_known_test{c}{i}{j});
                    pred_mat_unknown_test =horzcat(pred_mat_unknown_test,pred_unknown_test{c}{i}{j});
                     pred_mat_all_test{c}{i}{1} = pred_mat_known_test;
                     pred_mat_all_test{c}{i}{2} = pred_mat_unknown_test;
                end
            end


            for i = 1: length(Label) 
                yfit_known_test{c}{i} = cellfun(@str2num,Classifier{c}{i}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) ~= Label(i),1:28)));
                yfit_unknown_test{c}{i} = cellfun(@str2num,Classifier{c}{i}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Label(i),1:28)));
            end

            for j = 1 : length(Label)
                 tteemmpp_all = new_test_data_balanced_10(new_test_data_balanced_10(:,32) ~= Label(j),:);
                for i = 1 : length(Label)
                     temp_2_all = (tteemmpp_all(:,32) == i);
                     temp_pred_mat_all = [];
                %      logi_test1{i} = (test_mat(:,32) == i);
                %     
                      %&  logi_pred{i}
                      if(i == j)
                          temp_pred_mat_all = cellfun(@str2num,pred_mat_all_test{c}{j}{2});
            %                 op_fn = @(x) sum(pred_mat_all{j}((test_zeros(:,32) == i) ,:)==x,2);     
                      else
                         temp_pred_mat_all = cellfun(@str2num,pred_mat_all_test{c}{j}{1});
                         temp_pred_mat_all = temp_pred_mat_all(temp_2_all,:);
                      end
                      op_fn = @(x) sum(temp_pred_mat_all ==x,2);
                      vote_count_all_all_test{c}{j,i} = arrayfun(op_fn,[1:length(Label)],'UniformOutput',false);
                end
            end
            
            for i = 1 : length(Label)
                temp = [];
                for j = 1 : length(Label)
                    temp = vertcat(temp,cat(2,vote_count_all_all_test{c}{i,j}{:}));
                end
                group_vote_counts_test{c}{i} = temp;
            end

%% Bayes
        for cc = 1 : length(Label)
            for i = 1 : length(Label) 
                   temp = group_vote_counts_test{c}{cc}(new_test_data_balanced_10(:,32) == Label(i),:);
                   if(~isempty(temp))
                     if(Label(i) == Label(cc))
                        temp_yfit = yfit_unknown_test{c}{cc};
                        tteemmpp1 = new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Label(cc),:);
                     else
                         tteemmpp1 = new_test_data_balanced_10(new_test_data_balanced_10(:,32) ~= Label(cc),:);
                         tteemmpp2 = (tteemmpp1(:,32) == Label(i));
                         temp_yfit = yfit_known_test{c}{cc}(tteemmpp2);
                     end
                     temp = horzcat(temp,tteemmpp1(tteemmpp1(:,32) == Label(i),31));
                     temp = horzcat(temp,temp_yfit);
                     unique_flows = unique(temp(:,length(Label) + 1 ));
                     f_special = @(x) sum(temp(:,length(Label) + 1) == x);
                     unique_flows_counts =  arrayfun(f_special,unique_flows);
                     unique_flows_stats_eff = unique_flows(unique_flows_counts > 2); %params.min_flow_length
                     unique_flows_counts = unique_flows_counts( unique_flows_counts > 2); %params.min_flow_length
                     for j =  1 : size(unique_flows_stats_eff,1)
        %                  if(i == 2 & c == 6)
        %                      oo = 0 ;
        %                  end
                         unique_flow = temp(temp(:,length(Label) + 1) == unique_flows_stats_eff(j),:);
                         w = 3;% best_params.w;
                         alpha = 0.50 ;% best_params.alpha;
                         lambda_i_j_history = 0.50;% best_params.lambda_i_j_history;
                         lambda_i_j_future = 0.50;% best_params.lambda_i_j_future;
                         sample_class_index = zeros(1,unique_flows_counts(j));
                         high_confidence_samples_ind = zeros(1,unique_flows_counts(j));
                         low_confidence_samples_ind = zeros(1,unique_flows_counts(j));
                         temp_decision = zeros(unique_flows_counts(j),length(Label));

                         for k = 1: unique_flows_counts(j)

                            temp_decision(k,:) =  (unique_flow(k,1:length(Label)) >= (mean_mean_acc{c} - mean_std_acc{c}));
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
                                        counter = 1;
                                        for l = k+1  : temp_w_future
                                            temp_decision_future(counter,:) = (unique_flow(l,1:length(Label)) >= (mean_mean_acc{c} - mean_std_acc{c}));
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
                                    counter = 1;
                                    for l = k+1  : temp_w_future
                                        temp_decision_future(counter,:) = (unique_flow(l,1:length(Label)) >= (mean_mean_acc{c} - mean_std_acc{c}));
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

                                    if(temp_most_appearing_class_ratios(top_ratio) > 0.85) % best_params.confidence_ratio
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