function [ ssr,snd ] = CrossCorr2D( X,Y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
r = xcorr2 (X,Y);

[ssr,snd] = max(r(:));
%[ij,ji] = ind2sub(size(r),snd);
figure
plot(r(:))
title('Cross-Correlation')
hold on
plot(snd,ssr,'or')
hold off
text(snd*1.05,ssr,'Maximum')

end

