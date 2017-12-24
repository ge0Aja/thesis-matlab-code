parfor c = 1 : 9 
train = Data_Sets{c}{1};
test = Data_Sets{c}{2};

    tf_test = @(x) sum(test(:,32) == x);
    tf_train = @(x) sum(train(:,32) == x);

    train_counts = arrayfun(tf_train,unique(train(:,32)));
    test_counts = arrayfun(tf_test,unique(test(:,32)));
    
    if (c == 3)
        test_counts = [0;test_counts];
    end
    
    
    min_count_exp_w = min(train_counts([1:length(Label)]  & [1:6] ~=2 )); % & [1:6] ~= l
    
    for pp = 1 : 15
    
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
        
             new_test_data_balanced_10(new_test_data_balanced_10(:,32) == 2,:) = [] ;
             new_train_data_balanced(new_train_data_balanced(:,32) == 2,:) = [] ;
             
%              new_test_data_balanced_10(new_test_data_balanced_10(:,32) == 1,:) = [] ;
%              new_train_data_balanced(new_train_data_balanced(:,32) == 1,:) = [] ;
% %              
%              new_test_data_balanced_10(new_test_data_balanced_10(:,32) == 6,:) = [] ;
%              new_train_data_balanced(new_train_data_balanced(:,32) == 6,:) = [] ;

%             [tr_b,te_b] = getTrain_Test(browsing2,1,[1]);

            [tr,te] = getTrain_Test( game_321_2_2,22,[2]); %Game_long
            
%             [tr_g2,te_g2] = getTrain_Test( game2,1,[7]); %Game_long
%             [tr_s,te_s] = getTrain_Test(SoundCloud_G,1,[7]); 
            
%             tr_v(tr_v(:,1) < 20 & tr_v(:,2) < 20 & tr_v(:,32) == 6,:) = [];
%             te_v(te_v(:,1) < 20 & te_v(:,2) < 20 & te_v(:,32) == 6,:) = [];
            
           
            
%             add_train = cat(1,tr_b,tr);
%             add_test = cat(1,te_b,te);

            new_train_data_balanced = vertcat(new_train_data_balanced,tr);
            new_test_data_balanced_10 = vertcat(new_test_data_balanced_10,te);
            
% 
%             new_train_data_balanced = vertcat(add_train,new_train_data_balanced);
%             new_test_data_balanced_10 = vertcat(add_test,new_test_data_balanced_10);
%             

             new_train_data_balanced(isnan(new_train_data_balanced)) = 0 ;
            new_train_data_balanced(isinf(new_train_data_balanced)) = 0 ;

            new_test_data_balanced_10(isnan(new_test_data_balanced_10)) = 0 ;
            new_test_data_balanced_10(isinf(new_test_data_balanced_10)) = 0 ;
     
            
%             new_test_data_balanced_10(new_test_data_balanced_10(:,32) == 2 & new_test_data_balanced_10(:,2) < 2,:) = [] ;
%             new_train_data_balanced(new_train_data_balanced(:,32) == 2 & new_train_data_balanced(:,2) < 2,:) = [] ;
%            
%             trainedClassifier8Users = trainClassifierBagged28Features(new_train_data_balanced);
            
%             pred = trainedClassifier8Users.predictFcn(new_test_data_balanced_10(:,1:28));
%             conf = confusionmat(new_test_data_balanced_10(:,32),pred);
            
%             [tpr{c}(pp,:),fpr{c}(pp,:),f1{c}(pp,:)] = CalcTRPFPR(conf);
            
       
            [~,ParRes22{c}{pp}] = parRandForesttest( new_train_data_balanced,new_test_data_balanced_10,30,28,1);
           
             fprintf('finished for iteration %d user %d\n',pp,c)
    end
    
    fprintf('\n\nfinished for user %d\n\n',c)
end
         
% 
% for i = 1 : length(f1)
%     mean_f1(i,:) = mean(f1{i});
% end