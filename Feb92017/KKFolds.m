function [ dataset ] = KKFolds(c,Data_Sets22,Label,Extra_Apps,Extra_Labels,Game_G)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
 train = Data_Sets22{c}{1};
 test = Data_Sets22{c}{2};

    tf_test = @(x) sum(test(:,32) == x);
    tf_train = @(x) sum(train(:,32) == x);

    train_counts = arrayfun(tf_train,unique(train(:,32)));
    test_counts = arrayfun(tf_test,unique(test(:,32)));
  
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
        
        
         new_test_data_balanced_10(new_test_data_balanced_10(:,32) == 2,:) = [] ;
         new_train_data_balanced(new_train_data_balanced(:,32) == 2,:) = [] ;

         
         [tr_g,te_g] = getTrain_Test( Game_G,1,[2]); %Game_long
         

%         for ppq = 1: length(Extra_Labels)
% %              new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Extra_Labels(ppq),:) = [] ;
% %              new_train_data_balanced(new_train_data_balanced(:,32) == Extra_Labels(ppq),:) = [] ;
% % %              new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == Extra_Labels(ppq),:) = [] ;
%              Label(Label == Extra_Labels(ppq)) = [] ;
%         end
             
             
%              parfor ll = 1 : length(Extra_Labels)
% %               [~,val{ll}] = getTrain_Test(Extra_Apps{ll},1,Extra_Labels(ll));
%               [tr{ll},te{ll}] = getTrain_Test(Extra_Apps{ll},1,Extra_Labels(ll));
%              end
             
              parfor ll = 1 : length(Extra_Labels)
                  temp = Extra_Apps{ll};
                  test_ind = randperm(size(temp,1),round(size(temp,1) * 0.1));
                  te{ll} = temp(test_ind,:);
                  temp(test_ind,:) = [];
                  tr{ll} = temp;
%                   [tr{ll},te{ll}] = getTrain_Test(Extra_Apps{ll},1,Extra_Labels(ll));
             end
             
%              all_val = cat(1,val{:});
             all_tr = cat(1,tr{:},tr_g);
             all_te = cat(1,te{:},te_g);
             
             Extended_Label = sort(horzcat(Label,Extra_Labels));

             new_new_train = [];
             new_new_test = []; 
%              new_new_val = [];
             
             for ll = 1 : length(Extended_Label)
                if(sum(Label == Extended_Label(ll)) > 0 )
                    if(Extended_Label(ll) ~= 2)
                    new_new_train = vertcat(new_new_train,new_train_data_balanced(new_train_data_balanced(:,32) == Extended_Label(ll),:));
                    new_new_test = vertcat(new_new_test,new_test_data_balanced_10(new_test_data_balanced_10(:,32) == Extended_Label(ll),:));
%                     new_new_val = vertcat(new_new_val,new_validate_data_balanced_10(new_validate_data_balanced_10(:,32) == Extended_Label(ll),:));
                    else
                        new_new_train = vertcat(new_new_train,all_tr(all_tr(:,32) == Extended_Label(ll),:));
                        new_new_test = vertcat(new_new_test,all_te(all_te(:,32) == Extended_Label(ll),:));
%                  
                    end
                else
                    new_new_train = vertcat(new_new_train,all_tr(all_tr(:,32) == Extended_Label(ll),:));
                    new_new_test = vertcat(new_new_test,all_te(all_te(:,32) == Extended_Label(ll),:));
%                     new_new_val = vertcat(new_new_val,all_val(all_val(:,32) == Extended_Label(ll),:));
                end
             end
             
             new_train_data_balanced = new_new_train;
             new_test_data_balanced_10 = new_new_test;

            new_train_data_balanced(isnan(new_train_data_balanced)) = 0 ;
            new_train_data_balanced(isinf(new_train_data_balanced)) = 0 ;

            new_test_data_balanced_10(isnan(new_test_data_balanced_10)) = 0 ;
            new_test_data_balanced_10(isinf(new_test_data_balanced_10)) = 0 ;
            
%              parfor l = 1 : length(Extended_Label)
%                 [~,ParResT{l}] = parRandForesttest(new_train_data_balanced(new_train_data_balanced(:,32) ~= Extended_Label(l),:),new_test_data_balanced_10,30,28,1); % (new_test_data_balanced_10(:,32) ~= Extended_Label(l) & new_test_data_balanced_10(:,32) ~= pairs(l)
%              end 

        dataset{1} = new_train_data_balanced;
        dataset{2} = new_test_data_balanced_10;

end

