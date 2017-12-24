function [ finaloutlier ] = incaseoffuckinside( AppsInd,prove,j,newdata,B)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here

N=33;
k = prove(j,end);
parfor i=1:33
    c = randperm(length(newdata(AppsInd{k},:)),N);
    matr = newdata(c,:);
    tocalc = vertcat(prove(j,:),matr);
    outlier = outlierMeasure(B.compact,tocalc(:,[false false false true true false false false false false false true false false false true false false false false false false false true false false false false false]),'Labels',tocalc(:,end));
    
    seqoutlier(i) = outlier(1);
end
    finaloutlier = mean(seqoutlier);
    
    

end

