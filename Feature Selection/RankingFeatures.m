
    PredictorDeltaError = [];
    PredictorMeanMargin = [];
for i = 1 : 9
    PredictorDeltaError = vertcat(PredictorDeltaError,B{i}.OOBPermutedPredictorDeltaError);
    PredictorMeanMargin = vertcat(PredictorMeanMargin,B{i}.OOBPermutedPredictorDeltaMeanMargin);
end

mDeltaError = mean(PredictorDeltaError);
mDeltaMeanMargin = mean(PredictorMeanMargin);

mDeltaError = mDeltaError ./ mean(mDeltaError);
mDeltaMeanMargin = mDeltaMeanMargin ./ mean(mDeltaMeanMargin);

parfor i =1 : 9
    [Rank{i},Weight{i}] = relieff(DataSets{i}{1}(:,1:28),DataSets{i}{1}(:,end),5);
end

    weights = [];
    ranks = [];
for i =1 : 9
    weights = vertcat(weights,Weight{i});
    ranks = vertcat(ranks,Rank{i});
end

for j =1: 6
    for i =1:9
        
[R{i}(:,j),W{i}(:,j)]= rankfeatures(DataSets{i}{1}(:,1:28)',(DataSets{i}{1}(:,end)==j)','Criterion','roc');
    end
end

for i = 1 : 6
newRwilcoxon(:,i) = mean(horzcat(Rwilcoxon{1}(:,i),Rwilcoxon{2}(:,i),Rwilcoxon{3}(:,i),Rwilcoxon{4}(:,i),Rwilcoxon{5}(:,i),Rwilcoxon{6}(:,i),Rwilcoxon{7}(:,i),Rwilcoxon{8}(:,i),Rwilcoxon{9}(:,i)),2);
end


RankFacebookRoc = [];
RankGameRoc = [];
RankSkypeRoc = [];
RankViberRoc = [];
RankWhatsAppRoc = [];
RankYoutubeRoc = [];

for i =1:9
    RankFacebookRoc(:,i)  = horzcat(Rroc{i}(:,1));
     RankGameRoc(:,i)  = horzcat(Rroc{i}(:,2));
     RankSkypeRoc(:,i)  = horzcat(Rroc{i}(:,3));
      RankViberRoc(:,i)  = horzcat(Rroc{i}(:,4));
      RankWhatsAppRoc(:,i)  = horzcat(Rroc{i}(:,5)); 
       RankYoutubeRoc(:,i)  = horzcat(Rroc{i}(:,6)); 
end
    Apps = {'Facebook','8 Ball Pool','Skype','Viber','WhatsApp','Youtube'};
    figure
for i = 1 : 6
    subplot(2,3,i);
    bar(newWwilcoxonAverage(:,i));
    grid;
    title(strcat(Apps{i},'Features Weight in Wilcoxon mode'));
end
    



test = DataSets{1}{1}(:,1:28)';
testlabel = DataSets{1}{1}(:,end)';