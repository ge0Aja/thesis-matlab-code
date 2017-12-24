% for i = 1 : length(Users_Data)
%     Users_Data{i}(Users_Data{i}(:,32) ==2,:) = [] ; 
% end

 
%    Apps = [1 3 4 5 6];
%    Users = [1 2 3 4 5 6 7 8 9];
%    all_data_renumbered = [] ;
%    for j =  1 : length(Apps)
%     flow_counter = 1 ;
%     updated_temp = [];
%          for i = 1 : length(Users)   
%            temp = Users_Data{i}(Users_Data{i}(:,32) == Apps(j),:);
%            temp_flows = unique(temp(:,31));
%            for k =1 : length(temp_flows)
%                 temp_single_flow = temp(temp(:,31) == temp_flows(k),:);
%                 temp_single_flow(:,31) = flow_counter;
%                 updated_temp = vertcat(updated_temp,temp_single_flow);
%                 flow_counter = flow_counter+1;
%            end
%          end
%          all_data_renumbered = vertcat(all_data_renumbered,updated_temp);
%    end
%            
% all_data_renumbered = vertcat(all_data_renumbered,game_321_2_2) ;         
clear KFold_Apps
clear ParRes
parfor i = 1 : 8
%     [tr{i},te{i}] = getTrain_Test(all_data_renumbered2,20,Apps([1:8] ~= Apps(i))); %
%     KFold_Apps{i}{1} = tr{i};
%     KFold_Apps{i}{2} = vertcat(te{i},all_data_renumbered2(all_data_renumbered2(:,32)==Apps(i),:));
%      KFold_Apps{i}{2} = te;
    [~,ParRes{i}] = parRandForesttest(KFold_Apps{i}{1},KFold_Apps{i}{2},30,18,1);
end
% 
% for i =1 : 30
%     f1(i,:) = ParRes{i}{4};
% end