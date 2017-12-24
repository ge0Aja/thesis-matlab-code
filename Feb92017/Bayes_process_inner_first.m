function [ group_vote_counts_test,new_test_data_balanced_10,mean_mean_acc,mean_std_acc ,yfit_unknown_test,yfit_known_test,Extended_Label] = Bayes_process_inner_first(c,Data_Sets22,Label,Extra_Apps,Extra_Labels)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
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
    
     parfor i = 1 : length(Label)
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
        parfor i = 1 : length(Label)
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
        parfor i = 1 : length(Label)
            temp = validate(validate(:,32) == Label(i),:);
            if(~isempty(temp))
            temp_validate_samples_count = round(train_balanced_counts(i).* 0.2);
            if(temp_validate_samples_count > validate_counts(i))
                temp_validate_samples_count = validate_counts(i);
            end
            new_validate_data_balanced_10 = vertcat(new_validate_data_balanced_10,temp(randperm(validate_counts(i),temp_validate_samples_count),:));
            end
        end
        
        for ppq = 1: length(Extra_Labels)
             new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Extra_Labels(ppq),:) = [] ;
             new_train_data_balanced(new_train_data_balanced(:,32) == Extra_Labels(ppq),:) = [] ;
             new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == Extra_Labels(ppq),:) = [] ;
             Label(Label == Extra_Labels(ppq)) = [] ;
        end
             
             
             parfor ll = 1 : length(Extra_Labels)
              [~,val{ll}] = getTrain_Test(Extra_Apps{ll},1,Extra_Labels(ll));
              [tr{ll},te{ll}] = getTrain_Test(Extra_Apps{ll},1,Extra_Labels(ll));
             end
             
             all_val = cat(1,val{:});
             all_tr = cat(1,tr{:});
             all_te = cat(1,te{:});
             
             Extended_Label = sort(horzcat(Label,Extra_Labels));

             new_new_train = [];
             new_new_test = []; 
             new_new_val = [];
             
             for ll = 1 : length(Extended_Label)
                if(sum(Label == Extended_Label(ll)) > 0 )
                    new_new_train = vertcat(new_new_train,new_train_data_balanced(new_train_data_balanced(:,32) == Extended_Label(ll),:));
                    new_new_test = vertcat(new_new_test,new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Extended_Label(ll),:));
                    new_new_val = vertcat(new_new_val,new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == Extended_Label(ll),:));
                else
                    new_new_train = vertcat(new_new_train,all_tr(all_tr(:,32) == Extended_Label(ll),:));
                    new_new_test = vertcat(new_new_test,all_te(all_te(:,32) == Extended_Label(ll),:));
                    new_new_val = vertcat(new_new_val,all_val(all_val(:,32) == Extended_Label(ll),:));
                end
             end
             
             new_train_data_balanced = new_new_train;
             new_test_data_balanced_10 = new_new_test;
             new_validate_data_balanced_10 = new_new_val;

            new_train_data_balanced(isnan(new_train_data_balanced)) = 0 ;
            new_train_data_balanced(isinf(new_train_data_balanced)) = 0 ;

            new_test_data_balanced_10(isnan(new_test_data_balanced_10)) = 0 ;
            new_test_data_balanced_10(isinf(new_test_data_balanced_10)) = 0 ;
            
            new_validate_data_balanced_10(isnan(new_validate_data_balanced_10)) = 0 ;
            new_validate_data_balanced_10(isinf(new_validate_data_balanced_10)) = 0 ; 
            
            parfor l = 1 : length(Extended_Label)
                [Classifier{l},ParResV] = parRandForesttest( new_train_data_balanced(new_train_data_balanced(:,32) ~= Extended_Label(l),:),new_validate_data_balanced_10,30,28,1);
            end     
%             clear pred_known
%             clear pred_unknown
            parfor l = 1 : length(Extended_Label)
                for j = 1: 30
                     pred_known{l}{j}  =Classifier{l}.Trees{j}.predict(new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) ~= Extended_Label(l),1:28));
                     pred_unknown{l}{j}  = Classifier{l}.Trees{j}.predict(new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == Extended_Label(l),1:28));
                end
            end
            
%             clear pred_mat_all
            parfor i = 1 : length(Extended_Label)
                pred_mat_known = [];
                pred_mat_unknown = [];
                for j = 1 : 30
                     pred_mat_known = horzcat(pred_mat_known,pred_known{i}{j});
                     pred_mat_unknown =horzcat(pred_mat_unknown,pred_unknown{i}{j});
                     pred_mat_all{i}{1} = pred_mat_known;
                     pred_mat_all{i}{2} = pred_mat_unknown;
                end
            end
            
            
            for j = 1 : length(Extended_Label)
                tteemmpp = new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) ~= Extended_Label(j),:); % test_zeros(test_zeros(:,32) ~= j,:);
                for i = 1 : length(Extended_Label)
                     temp_2 = (tteemmpp(:,32) == Extended_Label(i));
                     temp_pred_mat = [];
                      if(i == j)
                          temp_pred_mat = cellfun(@str2num,pred_mat_all{j}{2});    
                      else
                         temp_pred_mat = cellfun(@str2num,pred_mat_all{j}{1});
                         temp_pred_mat = temp_pred_mat(temp_2,:);
                      end
                      op_fn = @(x) sum(temp_pred_mat ==x,2);
                      vote_count_all{j,i} = arrayfun(op_fn,[1:length(Extended_Label)],'UniformOutput',false);
                end
            end

            parfor i = 1: length(Extended_Label) 
                yfit_known{i} = cellfun(@str2num,Classifier{i}.predict(new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) ~= Extended_Label(i),1:28)));
                yfit_unknown{i} = cellfun(@str2num,Classifier{i}.predict(new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == Extended_Label(i),1:28)));
            end            
            for i = 1 : length(Extended_Label)
                for j = 1 : length(Extended_Label)
                    temp = cat(2,vote_count_all{i,j}{:});
            %         tteemmpp = test_zeros(test_zeros(:,32) ~= i,:);
                     tteemmpp = new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) ~= Extended_Label(i),:);
                    if(Extended_Label(i) ~= Extended_Label(j))
            %             temp_2 = test_zeros(test_zeros(:,32) == j,32);
                        temp_2 = tteemmpp(tteemmpp(:,32) == Extended_Label(j),32);
            %             temp_yfit = yfit(test_zeros(:,32) == j,i);
                        temp_yfit = yfit_known{i}((tteemmpp(:,32) == Extended_Label(j)),:);
                        ma_temp = mean(temp( temp_2 & (temp_yfit==Extended_Label(j)) ,:));
                        sa_temp = std(temp( temp_2 & (temp_yfit==Extended_Label(j)) ,:));
                        mean_accurate_class(i,j) = ma_temp(j);
                        std_accurate_class(i,j) = sa_temp(j);

                        mean_accurate_otherclasses{i}(j,:) = ma_temp;
                        std_accurate_otherclasses{i}(j,:) = sa_temp;

                        std_accurate_otherclasses{i}(j,j) = NaN;
                        mean_accurate_otherclasses{i}(j,j) = NaN;
                    else
                        mean_unknown(i,:) = mean(temp);
                    end
                end
            end

            %% create an accumulated matrix of vote counts 
            parfor i = 1 : length(Extended_Label)
                temp = [];
                for j = 1 :length(Extended_Label)
                    temp = vertcat(temp,cat(2,vote_count_all{i,j}{:}));
                end
                group_vote_counts{i} = temp;
            end
            %% caculate mean mean stats 
            for i = 1 : length(Extended_Label)
            % mean_mean_test_f1(i) = mean(test_f1([1:8]~=i,i))
            mean_mean_acc(i) = mean(mean_accurate_class([1:length(Extended_Label)]~=i,i));
            % mean_mean_inacc(i) = mean(mean_inaccurate_class([1:8]~=i,i));

            mean_std_acc(i) = mean(std_accurate_class([1:length(Extended_Label)]~=i,i));
            % mean_std_inacc(i) = mean(mean_inaccurate_class([1:8]~=i,i));
            end
  
            %% testing using test dataset 

            for i = 1 : length(Extended_Label)
                for j = 1: 30
            %         pred{i}{j}  = Classifiers_group{i}.Trees{j}.predict(test_zeros(:,1:28));
                    pred_known_test{i}{j}  =Classifier{i}.Trees{j}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) ~= Extended_Label(i),1:28));
                    pred_unknown_test{i}{j}  =Classifier{i}.Trees{j}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Extended_Label(i),1:28));
                end
            end

            parfor i = 1 : length(Extended_Label)
               pred_mat_known_test = [];
               pred_mat_unknown_test = [];
                for j =1 : 30
            %         pred_mat = horzcat(pred_mat,cellfun(@str2num,pred{i}{j}));
                    pred_mat_known_test = horzcat(pred_mat_known_test,pred_known_test{i}{j});
                    pred_mat_unknown_test =horzcat(pred_mat_unknown_test,pred_unknown_test{i}{j});
                     pred_mat_all_test{i}{1} = pred_mat_known_test;
                     pred_mat_all_test{i}{2} = pred_mat_unknown_test;
                end
            end


            for i = 1: length(Extended_Label) 
                yfit_known_test{i} = cellfun(@str2num,Classifier{i}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) ~= Extended_Label(i),1:28)));
                yfit_unknown_test{i} = cellfun(@str2num,Classifier{i}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Extended_Label(i),1:28)));
            end

            for j = 1 : length(Extended_Label)
                 tteemmpp_all = new_test_data_balanced_10(new_test_data_balanced_10(:,32) ~= Extended_Label(j),:);
                for i = 1 : length(Extended_Label)
                     temp_2_all = (tteemmpp_all(:,32) == i);
                     temp_pred_mat_all = [];
                %      logi_test1{i} = (test_mat(:,32) == i);
                %     
                      %&  logi_pred{i}
                      if(i == j)
                          temp_pred_mat_all = cellfun(@str2num,pred_mat_all_test{j}{2});
            %                 op_fn = @(x) sum(pred_mat_all{j}((test_zeros(:,32) == i) ,:)==x,2);     
                      else
                         temp_pred_mat_all = cellfun(@str2num,pred_mat_all_test{j}{1});
                         temp_pred_mat_all = temp_pred_mat_all(temp_2_all,:);
                      end
                      op_fn = @(x) sum(temp_pred_mat_all ==x,2);
                      vote_count_all_all_test{j,i} = arrayfun(op_fn,[1:length(Extended_Label)],'UniformOutput',false);
                end
            end
            
            for i = 1 : length(Extended_Label)
                temp = [];
                for j = 1 : length(Extended_Label)
                    temp = vertcat(temp,cat(2,vote_count_all_all_test{i,j}{:}));
                end
                group_vote_counts_test{i} = temp;
            end

end

