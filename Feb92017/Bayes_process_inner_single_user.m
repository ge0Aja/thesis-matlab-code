function [ group_vote_counts_test,test,mean_mean_acc,mean_std_acc ,yfit_unknown_test,yfit_known_test,test_counts,validate_counts,train_counts,Label] = Bayes_process_inner_single_user(train,test,validate,Label,prct,learners,predictors,min_leaf)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

%     [train,test] = getTrain_TestEnhanced(Data_Set,prct,Label);
%     [~,validate] = getTrain_TestEnhanced(Data_Set,prct,Label);

    validate = validate;
%     tf_test = @(x) sum(test(:,32) == x);
%     tf_train = @(x) sum(train(:,32) == x);
%     tf_validate = @(x) sum(validate(:,32) == x);

    train_counts = arrayfun(@(x) sum(train(:,32) == x),unique(train(:,32)));
    test_counts = arrayfun(@(x) sum(test(:,32) == x),unique(test(:,32)));
    validate_counts = arrayfun(@(x) sum(validate(:,32) == x),unique(validate(:,32)));

%     
%     fprintf('train_counts %d , test_counts %d, validate_counts %d \n',train_counts,test_counts,validate_counts)
    
%     if(any(test_counts == 0)  || any(validate_counts == 0) || any(train_counts == 0) )
%         group_vote_counts_test = [];
%         test = [];
%         mean_mean_acc= [];
%         mean_std_acc = [];
%         yfit_unknown_test = [];
%         yfit_known_test = [];
%         fprintf('invalid dataset return...\n')
%         return
%     end
       
            
    parfor l = 1 : length(Label)
        [Classifier{l},~] = parRandForesttest(train(train(:,32) ~= Label(l),:),validate,learners,predictors,min_leaf);
    end     
%             clear pred_known
%             clear pred_unknown

    fprintf(' got the classifiers \n')
    parfor l = 1 : length(Label)
        for j = 1: learners
             pred_known{l}{j}  =Classifier{l}.Trees{j}.predict(validate(validate(:,32) ~= Label(l),1:28));
             pred_unknown{l}{j}  = Classifier{l}.Trees{j}.predict(validate(validate(:,32) == Label(l),1:28));
        end
    end
    

%             clear pred_mat_all
    parfor i = 1 : length(Label)
        pred_mat_known = [];
        pred_mat_unknown = [];
        for j = 1 : learners
             pred_mat_known = horzcat(pred_mat_known,pred_known{i}{j});
             pred_mat_unknown =horzcat(pred_mat_unknown,pred_unknown{i}{j});
             pred_mat_all{i}{1} = pred_mat_known;
             pred_mat_all{i}{2} = pred_mat_unknown;
        end
    end
            
            
%     for j = 1 : length(Label)
%         tteemmpp = validate(validate(:,32) ~= Label(j),:); % test_zeros(test_zeros(:,32) ~= j,:);
%         for i = 1 : length(Label)
%              temp_2 = (tteemmpp(:,32) == Label(i));
%              temp_pred_mat = [];
%               if(i == j)
%                   temp_pred_mat = cellfun(@str2num,pred_mat_all{j}{2});    
%               else
%                  temp_pred_mat = cellfun(@str2num,pred_mat_all{j}{1});
%                  temp_pred_mat = temp_pred_mat(temp_2,:);
%               end
%               op_fn = @(x) sum(temp_pred_mat ==x,2);
%               vote_count_all{j,i} = arrayfun(op_fn,Label,'UniformOutput',false);
%         end
%     end
    
%     tic
parfor j = 1 : length(Label)
        tteemmpp = validate(validate(:,32) ~= Label(j),:); % test_zeros(test_zeros(:,32) ~= j,:);
        for i = 1 : length(Label)
             temp_2 = (tteemmpp(:,32) == Label(i));
             temp_pred_mat = [];
              if(i == j)
                 temp_pred_mat = cellfun(@str2num,pred_mat_all{j}{2});    
              else
                 temp_pred_mat = cellfun(@str2num,pred_mat_all{j}{1});
                 temp_pred_mat = temp_pred_mat(temp_2,:);
              end
              op_fn = @(x) sum(temp_pred_mat ==x,2);
              vote_count_all{j}{i} = arrayfun(op_fn,Label,'UniformOutput',false);
        end
end
% toc

    parfor i = 1: length(Label) 
        yfit_known{i} = cellfun(@str2num,Classifier{i}.predict(validate(validate(:,32) ~= Label(i),1:28)));
        yfit_unknown{i} = cellfun(@str2num,Classifier{i}.predict(validate(validate(:,32) == Label(i),1:28)));
    end     
    
    for i = 1 : length(Label)
        for j = 1 : length(Label)
            temp = cat(2,vote_count_all{i}{j}{:});
    %         tteemmpp = test_zeros(test_zeros(:,32) ~= i,:);
             tteemmpp = validate(validate(:,32) ~= Label(i),:);
            if(Label(i) ~= Label(j))
    %             temp_2 = test_zeros(test_zeros(:,32) == j,32);
                temp_2 = tteemmpp(tteemmpp(:,32) == Label(j),32);
    %             temp_yfit = yfit(test_zeros(:,32) == j,i);
                temp_yfit = yfit_known{i}((tteemmpp(:,32) == Label(j)),:);
                ma_temp = mean(temp( temp_2 & (temp_yfit==Label(j)) ,:));
                sa_temp = std(temp( temp_2 & (temp_yfit==Label(j)) ,:));
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
    parfor i = 1 : length(Label)
        temp = [];
        for j = 1 :length(Label)
            temp = vertcat(temp,cat(2,vote_count_all{i}{j}{:}));
        end
        group_vote_counts{i} = temp;
    end
    %% caculate mean mean stats 
    for i = 1 : length(Label)
    % mean_mean_test_f1(i) = mean(test_f1([1:8]~=i,i))
    mean_mean_acc(i) = mean(mean_accurate_class(Label~=Label(i),i));
    % mean_mean_inacc(i) = mean(mean_inaccurate_class([1:8]~=i,i));

    mean_std_acc(i) = mean(std_accurate_class(Label~=Label(i),i));
    % mean_std_inacc(i) = mean(mean_inaccurate_class([1:8]~=i,i));
    end

    %% testing using test dataset 

    for i = 1 : length(Label)
        for j = 1: learners
    %         pred{i}{j}  = Classifiers_group{i}.Trees{j}.predict(test_zeros(:,1:28));
            pred_known_test{i}{j}  =Classifier{i}.Trees{j}.predict(test(test(:,32) ~= Label(i),1:28));
            pred_unknown_test{i}{j}  =Classifier{i}.Trees{j}.predict(test(test(:,32) == Label(i),1:28));
        end
    end

    parfor i = 1 : length(Label)
       pred_mat_known_test = [];
       pred_mat_unknown_test = [];
        for j =1 : learners
    %         pred_mat = horzcat(pred_mat,cellfun(@str2num,pred{i}{j}));
            pred_mat_known_test = horzcat(pred_mat_known_test,pred_known_test{i}{j});
            pred_mat_unknown_test =horzcat(pred_mat_unknown_test,pred_unknown_test{i}{j});
             pred_mat_all_test{i}{1} = pred_mat_known_test;
             pred_mat_all_test{i}{2} = pred_mat_unknown_test;
        end
    end


    for i = 1: length(Label) 
        yfit_known_test{i} = cellfun(@str2num,Classifier{i}.predict(test(test(:,32) ~= Label(i),1:28)));
        yfit_unknown_test{i} = cellfun(@str2num,Classifier{i}.predict(test(test(:,32) == Label(i),1:28)));
    end

    parfor j = 1 : length(Label)
         tteemmpp_all = test(test(:,32) ~= Label(j),:);
        for i = 1 : length(Label)
             temp_2_all = (tteemmpp_all(:,32) == Label(i));
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
              vote_count_all_all_test{j}{i} = arrayfun(op_fn,Label,'UniformOutput',false);
        end
    end

    parfor i = 1 : length(Label)
        temp = [];
        for j = 1 : length(Label)
            temp = vertcat(temp,cat(2,vote_count_all_all_test{i}{j}{:}));
        end
        group_vote_counts_test{i} = temp;
    end

end

