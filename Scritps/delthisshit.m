quadTPRs = [];
quadFPRs = [];

guasTPRs = [];
guasFPRs = [];

baggedTPRs = [];
baggedFPRs = [];

complexTPRs = [];
complexFPRs = [];

guasF1s = [];
complexF1s = [];

annF1s = [];

for i=1:50
%     quadTPRs = vertcat(quadTPRs,Fin{i}{1});
%     quadFPRs = vertcat(quadFPRs,Fin{i}{2});
%     guasTPRs = vertcat(guasTPRs,Fin{i}{3});
%     guasFPRs = vertcat(guasFPRs,Fin{i}{4});
%     baggedTPRs =  vertcat(baggedTPRs,Fin{i}{5});
%     baggedFPRs =  vertcat(baggedFPRs,Fin{i}{6});
%     complexTPRs = vertcat(complexTPRs,Fin{i}{7});
%     complexFPRs = vertcat(complexFPRs,Fin{i}{8});
%     guasF1s = vertcat(guasF1s,Fin{i}{9});
     complexF1s = vertcat(complexF1s,Fin{i}{10});
% annF1s = vertcat(annF1s,Fin{i}{4});
end

acc = [];
for i=1:33
    acc = vertcat(acc,Fin{i});
end


mquadtpr = mean(quadTPRs);
mquadfpr = mean(quadFPRs);
mguasfpr = mean(guasFPRs);
mguastpr = mean(guasTPRs);
mcompfpr = mean(complexFPRs);
mcomptpr = mean(complexTPRs);
mbaggfpr = mean(baggedFPRs);
mbaggtpr = mean(baggedTPRs);
mguasF1 = mean(guasF1s);
mcomplexF1 = mean(complexF1s);
mannF1 = mean(annF1s);
%%
array = [];
for i =1:6
    for j = 1:length(Every{i})
        array = vertcat(array,Every{i}{j});
    end
end
%%
treesize = [200 150 100 80 60 40 30 20 10];
parfor i = 1 : length(treesize)
    class = trainBaggedTrees(newdata,treesize(i));
    predbagged = predict(class.ClassificationEnsemble,shuffled(:,[false false false true true false false false false false false true false false false true false false false false false false false true false false false false]));
    baggedconf = confusionmat(shuffled(:,end),predbagged);
    [baggedTPR,baggedFPR] = CalcTRPFPR( baggedconf );
    Fin{i}{1} = baggedTPR;
    Fin{i}{2} = baggedFPR;
end

%%

arrayFPR = [];
arrayTPR = [];
for i =1:9
        arrayFPR = vertcat(arrayFPR,Fin{i}{2});
        arrayTPR = vertcat(arrayTPR,Fin{i}{1});
    
end