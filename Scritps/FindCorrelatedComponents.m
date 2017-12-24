function [ output_args ] = FindCorrelatedComponents( sig1,sig2 )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    Fs =1;
    
    [Cxy,f] = mscohere(sig1,sig2,[],[],[],Fs);
    Pxy     = cpsd(sig1,sig2,[],[],[],Fs);
    phase   = -angle(Pxy)/pi*180;
    [pks,locs] = findpeaks(Cxy,'MinPeakHeight',0.75);
    
    figure
subplot(211);
plot(f,Cxy);
title('Coherence Estimate');
grid on;
hgca = gca;
hgca.XTick = f(locs);
hgca.YTick = .75;

subplot(212);
plot(f,phase);
title('Cross-spectrum Phase (deg)');
grid on;
hgca = gca;
hgca.XTick = f(locs);
hgca.YTick = round(phase(locs));
xlabel('Frequency (Hz)');



end

