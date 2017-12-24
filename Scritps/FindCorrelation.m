function [ output_args ] = FindCorrelation( X,Y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[acor,lag] = xcorr(X,Y);
Fs =1;

[~,I] = max(abs(acor));
lagDiff = lag(I);
timeDiff = lagDiff/Fs;

%figure
plot(lag,acor,'Color','b')

end

