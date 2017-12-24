clear train
clear test


[train,test] = getTrain_TestEnhanced( all_plus_dos_renumbered,10,Labels );



tf_test = @(x) sum(test(:,32) == x);
tf_train = @(x) sum(train(:,32) == x);
% tf_validate = @(x) sum(validate(:,32) == x);

train_counts = arrayfun(tf_train,unique(train(:,32)));
test_counts = arrayfun(tf_test,unique(test(:,32)));
% validate_counts = arrayfun(tf_validate,unique(validate(:,32)));

 fprintf('train_counts %d , test_counts %d \n',train_counts,test_counts)
    