for i = 1 : length(Stats)
    Stats{i}{2} = [] ;
end


for i = 1: 9 
    for j = 1 : length(Stats{i})
        if(~isempty( Stats{i}{j}))
         Stats6Apps9Users{i}{j} = Stats{i}{j}{1};
        end
    end
end

for i = 1 : 9
    Users_Data{i} = cat(1,Stats6Apps9Users{i}{:});
end

for i = 1 : 9
    Users_Data{i}(Users_Data{i}(:,1) ==1 & Users_Data{i}(:,2) == 0,:) =[];
    Users_Data{i}(Users_Data{i}(:,2) ==1 & Users_Data{i}(:,1) == 0,:) =[];
end

data  =cat(1,Users_Data{:});
dataset= vertcat(cat(1,Stats_Game{:}),cat(1,Users_Data{:}));


[tr,te] = getTrain_Test(dataset,1,apps);

tr(tr(:,32) ~= 2 &  tr(:,32) ~= 5 & tr(:,1) < 10 & tr(:,2) < 10,:) = [] ;


sum(tr(:,32) == 2 & tr(:,1) < 5 & tr(:,2) < 5 )


for i = 1 : length(Stats)
    for j = 1 : length(Stats{i})
        if(~isempty(Stats{i}{j}))
            Stats_new{i}{j} = Stats{i}{j}{1};
        end
    end
end


dataset = [];

for i = 1 : length(Stats)
    dataset = vertcat(dataset,cat(1,Stats_new{i}{:}));
end


dataset(dataset(:,32) == 322,33) = 6;


mini_dataset(mini_dataset(:,1) < 20 & mini_dataset(:,2) < 20 & mini_dataset(:,33) == 4,: ) = [];


dataset(dataset(:,32) ~= 5 & dataset(:,1) < 20 & dataset(:,2) < 20 ,:) = [] ;

Game_G(Game_G(:,1) < 10 & Game_G(:,2) < 10 ,:) = [] ;


for i = 1 : length(Users_Data)
    Users_Data{i}(Users_Data{i}(:,1) < 15 & Users_Data{i}(:,2) < 15 & Users_Data{i}(:,32) ~=5,: ) = []; %& Users_Data{i}(:,32) == 6
end

for i = 1 : length(Stats_Game)
    Stats_Game(Stats_Game{i}(:,1) < 10 & Stats_Game{i}(:,2) < 10 ,:) = [] ;
end





