for i = 1 : 9
test_data = [];
train_data = [];
validation_data = [] ;
for j = 1 : 9
if(i == j)
test_data = Users_Data{i};
else
validation_ind = round(rand * 9);
flag = false;
while(flag == false)
if(validation_ind ~= i && validation_ind ~= 3)
validation_data = Users_Data{j};
flag = true;
else
validation_ind = round(rand * 9);
end
end
train_data = vertcat(train_data,Users_Data{j});
end
end
Data_Sets22{i}{1} = train_data;
Data_Sets22{i}{2} = test_data;
Data_Sets22{i}{3} = validation_data;
end
clear train_data
clear test_data
clear validation_data