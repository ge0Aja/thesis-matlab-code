function [ pointoutlierscore, testpointoutlierscore ] = Calcpointoutliermeasure( B,test,snap )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
pointoutlierscore = [];
testpointoutlierscore = [];
classind = [1 2 3 4 5 6];
parfor t =1:length(snap)
classoutlier = [];
testclassoutlier = [];
    for p = 1 : 6
        % We should decrease the number of used points in outlier
        % calculation to take class representitives 
        outlierclasssamples = test((test(:,end)==classind(p)),:);
        if(sum(test(:,end)==classind(p)) ~= 0)
        zingi = outlierMeasure(B.compact,vertcat(snap(t,1:28),outlierclasssamples(randperm(length(outlierclasssamples),30),1:28)));
        classoutlier = horzcat(classoutlier,zingi(1,1));
        zingi2 = outlierMeasure(B.compact,outlierclasssamples(randperm(length(outlierclasssamples),30),1:28));
        testclassoutlier = horzcat(testclassoutlier,zingi2);
        end
    end
    testpointoutlierscore = vertcat(testpointoutlierscore,mean(testclassoutlier));
    pointoutlierscore = vertcat(pointoutlierscore,classoutlier);
%     outlier(i,:) = outlierMeasure(B.compact,test(:,1:28));
%     outliersnap(i,:) = outlierMeasure(B.compact,snap(:,1:28));
%     fprintf('Calculated Outliers for Test %d',i);

end
end


