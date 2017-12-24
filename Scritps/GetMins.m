function [ All ] = GetMins(X,Thresh)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
TempTime = 0;
j=1;
k=1;
Secs = cell2mat(X(:,9));
%Secs = X(:,9);
Time2 = cell2mat(X(:,10));
Length = cell2mat(X(:,6));

for i=1:length(Secs)
    if(TempTime <= Thresh && i~=length(Secs))
        TempTime = TempTime+Secs(i);
    else
        TempDestination = X(j:i,4);
        TempDstPort = X(j:i,7);
        TempLength = Length(j:i);
        TempNo = X(j:i,1);
        TempProtocol = X(j:i,5);
        TempSecs = X(j:i,9);
        TempSource = X(j:i,3);
        TempSrcPort = X(j:i,8);
        TempTimet = X(j:i,2);
        TempTime2 = Time2(j:i);
        
        All{k,1} =  TempDestination;
        All{k,2} = TempDstPort;
        All{k,3} = TempLength;
        All{k,4} = TempNo;
        All{k,5} = TempProtocol;
        All{k,6} = TempSecs;
        All{k,7} = TempSource;
        All{k,8} = TempSrcPort;
        All{k,9} = TempTimet;
        All{k,10} = TempTime2;
        
        TempTime = 0;
        k = k+1;
        j=i;
    end
    
end
fprintf('the number of Mins for a threshold %d is %d for input %s',Thresh./60,k,inputname(1));   

end

