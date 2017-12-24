function [ group_vote_counts_test,mean_mean_acc,mean_std_acc ,yfit_unknown_test,validate_counts,train_counts,test_labels] = Bayes_process_inner_nomal_dataset(Data_Set,test,Label,prct,learners,predictors,min_leaf)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    [train,validate] = getTrain_TestEnhanced(Data_Set,prct,Label);
    train_counts = arrayfun(@(x) sum(train(:,32) == x),unique(train(:,32)));
    validate_counts = arrayfun(@(x) sum(validate(:,32) == x),unique(validate(:,32)));

    [Classifier,~] = parRandForesttest(train,validate,learners,predictors,min_leaf);

    fprintf(' got the classifier \n')

    for j = 1: learners
        pred_known{j}  =Classifier.Trees{j}.predict(validate(:,1:28));
    end

    pred_mat_known = [];
    for j = 1 : learners
         pred_mat_known = horzcat(pred_mat_known,pred_known{j});
         pred_mat_all = pred_mat_known;
    end

     parfor co1 = 1 : length(Label)
         temp_2 = (validate(:,32) == Label(co1));
         temp_pred_mat = cellfun(@str2num,pred_mat_all);
         temp_pred_mat = temp_pred_mat(temp_2,:);

          op_fn = @(x) sum(temp_pred_mat == x,2);
          vote_count_all{co1} = arrayfun(op_fn,Label,'UniformOutput',false);
     end

      yfit_known = cellfun(@str2num,Classifier.predict(validate(:,1:28)));
      
    for j = 1 : length(Label)
        temp = cat(2,vote_count_all{j}{:});
%         temp_2 = (validate(:,32) == Label(j));

        temp_yfit = yfit_known((validate(:,32) == Label(j)),:);
        ma_temp = mean(temp(  (temp_yfit==Label(j)) ,:));
        sa_temp = std(temp(  (temp_yfit==Label(j)) ,:));
        mean_accurate_class(j) = ma_temp(j);
        std_accurate_class(j) = sa_temp(j);
    end

    %% create an accumulated matrix of vote counts 
    temp = [];
    for j = 1 :length(Label)
        temp = vertcat(temp,cat(2,vote_count_all{j}{:}));
    end
    group_vote_counts = temp;
        
    %% caculate mean mean stats 
    mean_mean_acc = mean_accurate_class;
    mean_std_acc = std_accurate_class;

    %% testing using test dataset 
    test_labels = unique(test(:,32));
    
    for i = 1 : length(test_labels)
        for j = 1: learners
            pred_unknown_test{i}{j}  =Classifier.Trees{j}.predict(test(test(:,32) == test_labels(i),1:28));
        end
    end

    parfor i = 1 : length(test_labels)
       pred_mat_unknown_test = [];
        for j =1 : learners
         pred_mat_unknown_test =horzcat(pred_mat_unknown_test,pred_unknown_test{i}{j});
         pred_mat_all_test{i} = pred_mat_unknown_test;
        end
    end

    for i = 1: length(test_labels) 
        yfit_unknown_test{i} = cellfun(@str2num,Classifier.predict(test(test(:,32) == test_labels(i),1:28)));
    end


    for i = 1 : length(test_labels)
     temp_pred_mat_all = [];
     temp_pred_mat_all = cellfun(@str2num,pred_mat_all_test{i});
     op_fn2 = @(x) sum(temp_pred_mat_all ==x,2);
     vote_count_all_all_test{i} = arrayfun(op_fn2,Label,'UniformOutput',false);

    end

    temp = [];
    for j = 1 : length(test_labels)
        temp = vertcat(temp,cat(2,vote_count_all_all_test{j}{:}));
    end
    group_vote_counts_test = temp;

end

