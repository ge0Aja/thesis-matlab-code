function [  ] = Bayes_process_inner_second( c,Data_Sets22,Label,Game_G,browsing_comb,best_params )
%UNTITLED3 Summary of this function goes here
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
        
        
         new_test_data_balanced_10(new_test_data_balanced_10(:,32) == 2,:) = [] ;
         new_train_data_balanced(new_train_data_balanced(:,32) == 2,:) = [] ;
         new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == 2,:) = [] ;


         new_test_data_balanced_10(new_test_data_balanced_10(:,32) == 1,:) = [] ;
         new_train_data_balanced(new_train_data_balanced(:,32) == 1,:) = [] ;
         new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == 1,:) = [] ;


        [~,val_b] = getTrain_Test(browsing_comb,1,[1]);
        [tr_b,te_b] = getTrain_Test(browsing_comb,1,[1]);

        [~,val] = getTrain_Test(Game_G,1,[2]); 
        [tr,te] = getTrain_Test(Game_G,1,[2]); 


        new_train_face  = tr_b;
        new_train_face_game = vertcat(new_train_face,tr);
        new_train_data_balanced = new_train_data_balanced(new_train_data_balanced(:,32) ~= 1,:);
        new_train_data_balanced = vertcat(new_train_face_game,new_train_data_balanced);

        new_test_face  = te_b;
        new_test_face_game = vertcat(new_test_face,te);
        new_test_data_balanced_10 = new_test_data_balanced_10(new_test_data_balanced_10(:,32) ~= 1,:);
        new_test_data_balanced_10 = vertcat(new_test_face_game,new_test_data_balanced_10);


        new_val_face  = val_b;
        new_val_face_game = vertcat(new_val_face,val);
        new_validate_data_balanced_10 = new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) ~= 1,:);
        new_validate_data_balanced_10 = vertcat(new_val_face_game,new_validate_data_balanced_10);

         parfor l = 1 : length(Label) 
            [Classifier{l},~] = parRandForesttest(new_train_data_balanced(new_train_data_balanced(:,32) ~= Label(l),:),new_validate_data_balanced_10,40,28,best_params.minLS);
         end
         
         parfor i = 1: length(Label) 
                yfit_known{i} = cellfun(@str2num,Classifier{i}.predict(new_validate_data_balanced_10(:,1:28)));    
         end 
         
         parfor l = 1 : length(Label)
             for j = 1 : length(Label)
                 if(Label(l) ~= Label(j))
                     prox_test_train = new_train_data_balanced(new_train_data_balanced(:,32)==Label(j),1:28);
                     prox_test_validate = new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == Label(j) & (yfit_known{l} == new_validate_data_balanced_10(:,32) & new_validate_data_balanced_10(:,32) == Label(j)),1:28);
                     size_prox_test_train = size(prox_test_train,1);
                     size_prox_test_validate = size(prox_test_validate,1);
                     
                     prox_test_j = vertcat(prox_test_train,prox_test_validate);
                     prox = proximity(Classifier{l}.compact,prox_test_j);
                     
                     prox_train_only = proximity(Classifier{l}.compact,prox_test_train);
                     
                     avg_prox{l}{j} = mean(prox(size_prox_test_train+1:end,1:size_prox_test_train),2);
%                      
                     for oo = 1: size_prox_test_train
                          avg_prox_train_only{l}{j}(oo) = mean(prox_train_only(oo,[1:size_prox_test_train] ~= oo));
                     end
                 end
             end
         end
         
          for i = 1 : length(Label)
                for j =  1 : length(Label)
                    if(Label(j) ~= Label(i))
                        mean_mean_acc(i,j) = mean(avg_prox{j}{i});
                        std_mean_acc(i,j) = std(avg_prox{j}{i});
                    else
                       mean_mean_acc(i,j) = 0;
                       std_mean_acc(i,j) = 0 ; 
                    end
                    
                end
          end
%% testing           
     
        parfor i = 1: length(Label) 
                yfit_known_test{i} = cellfun(@str2num,Classifier{i}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) ~= i,1:28)));    
                yfit_unknown_test{i} = cellfun(@str2num,Classifier{i}.predict(new_test_data_balanced_10(new_test_data_balanced_10(:,32) == i,1:28)));    
        end 
         
         parfor l = 1 : length(Label)
             for j = 1 : length(Label)
                 if(Label(l) ~= Label(j))
                     prox_test_train = new_train_data_balanced(new_train_data_balanced(:,32)==Label(j),1:28);
                     size_prox_test_train = size(prox_test_train,1);
                     for pp = 1 : length(Label)
                         prox_test_test = new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Label(pp),1:28);
                         prox_test_j = vertcat(prox_test_train,prox_test_test);
                         prox = proximity(Classifier{l}.compact,prox_test_j);
                         avg_prox_test{l}{j}{pp} = mean(prox(size_prox_test_train+1:end,1:size_prox_test_train),2);                              
                     end  
                 end
             end
         end
         
         
         
%          for i = 1: length(Label)
%              pred_mat_test = [];
%              for j = 1 : length(Label)
%                  if(Label(i) ~= Label(j))
%                      pred_mat_test(:,j) = avg_prox_test{i}{j};
%                  else
%                      size_z = sum(new_test_data_balanced_10(:,32) == Label(j));
%                      pred_mat_test(:,j) = zeros(size_z,1);
%                  end
%              end
%              pred_mat_all_test{i} = pred_mat_test;
%          end
%          
         oo = 1;
end

