
for i = 1 : 8 
    for j = 1 : 8
        ttpp2 = size(cat(1,Results_Decisions{i}{j}{:}),1);
        if(i ~= j)
           
           ttoo2 = sum(cat(1,Results_Decisions{i}{j}{:}) == 0);   
           ttoo3 = sum(cat(1,Results_Decisions{i}{j}{:}) == j);

           tq2(i,j) = ttoo2 ./ ttpp2;
           tq3(i,j) = ttoo3 ./ ttpp2;
        else
            ttoo1 = sum(cat(1,Results_Decisions{i}{j}{:}) ~= 0);
            ttoo = sum(cat(1,Results_Decisions{i}{j}{:}) == 0);
            tq(i) = ttoo ./ ttpp2;
            tq1(i) = ttoo1 ./ ttpp2;
        end
    end  
end

for i = 1 : 8
    temp_mean  =mean(tq2([1:8] ~= i,:));
    mean_mean_fpr(i) = temp_mean(i);
end
