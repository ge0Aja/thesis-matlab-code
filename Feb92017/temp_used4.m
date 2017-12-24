for i = 1 : length(Vids_stats)
    Vids_stats{i} = Vids_stats{i}{1};
end

Vids_stats_comb = cat(1,Vids_stats{:});


parfor i = 1 : 20
    [ParV{i},ParT{i}] = KKFolds(1,Data_Sets22,Label,Extra_Apps2,Extra_Labels2);
end


for i =1 : length(ParV)
        for j = 1 : length(ParV{i})
            
            f1{i}(j,:) = ParV{i}{j}{4};
            
        end
end


for i =1 : length(ParT)

            
            f1_T(i,:) = ParT{i}{4};
            
       
end

for i = 1: 9
mean_f1(i,:) = mean(f1{i});
end

yout_yout = [];
for i = 1 : 9 
    yout_yout = vertcat(yout_yout,Users_Data{i}(Users_Data{i}(:,32) == 6,:));
end


for i = 1: length(ParV)
    for j = 1  : 8
        mean_mean(i,j) =mean(f1{i}([1: 8] ~= j,j));
    end
%     mean_f1(i,:) = mean(mean_mean);
end


for i = 1: length(ParT)
    for j = 1  : 8
        mean_meanT(i,j) =mean(f1_T{i}([1: 8] ~= j,j));
    end
%     mean_f1(i,:) = mean(mean_mean);
end

prox_avg_whatsapp = mean(proximity_for_whatsapp_over_test_data,2);
               