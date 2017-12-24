function [ train,test ] = getTrain_TestEnhanced( stats_all_n,Q,apps )
    train = [];
    test = [];
    rng('shuffle');

for i = 1:length(apps) 
    temp_train_2 = [];
    temp_test = [];
%     while(size(temp_train_2,1) <= size(temp_test,1))
        temp_train = stats_all_n(stats_all_n(:,32) == apps(i),:);
        temp_test = [];
        temp_train_2 = [];
        temp_test_count = round((size(temp_train,1) * Q)/100);
        temp_train_count = size(temp_train,1)- temp_test_count;

        c = unique(temp_train(:,31));
        t_f = @(x) sum(temp_train(:,31) == x);
        s_cnn = arrayfun(t_f,c);
        fail_counter = 0;
        fail_counter2 = 0;
        
         while((size(temp_train_2,1) < temp_train_count))
            temp_i2 = randi([1 size(c,1)],1,1);
            j_inner2 = c(temp_i2);
           if((s_cnn(temp_i2) + size(temp_train_2,1)) <= (temp_train_count))
                temp_train_2 = vertcat(temp_train_2,temp_train(temp_train(:,31) == j_inner2,:));
                temp_train(temp_train(:,31) == j_inner2,:)  = [];
               s_cnn(temp_i2) = [];
               c(temp_i2) = [];
           else
               fail_counter2 = fail_counter2 +1;
%               continue;
           end
                if(fail_counter2 >= 10)
                     break;
                else
                    continue;
                end
         end
        temp_test = temp_train;
%         while((size(temp_test,1) < temp_test_count))
%             temp_i = randi([1 size(c,1)],1,1);
%             j_inner = c(temp_i);
%            if( (s_cnn(temp_i) + size(temp_test,1)) <= (temp_test_count) && size(temp_train,1) >= temp_train_count)
%                 temp_test = vertcat(temp_test,temp_train(temp_train(:,31) == j_inner,:));
%                 temp_train(temp_train(:,31) == j_inner,:)  = [];
%                 s_cnn(temp_i) = [];
%                 c(temp_i) = [];
%            else
%                fail_counter = fail_counter +1;
% %                continue;
%            end
% 
%         if(fail_counter >= 10)
%             break;
%         else
%             continue;
%         end
%         end
       

        train = vertcat(train,temp_train_2);
        test = vertcat(test,temp_test);
%     end
    end
end