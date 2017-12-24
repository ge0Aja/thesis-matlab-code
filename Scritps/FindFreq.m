function [ y] = FindFreq( Time, X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    Fs = 1;
    %N = 500;
    N = length(X);
    df = Fs/N;
    f = 0:df:Fs/2-df;
    N_2 = N/2;
    x_mags = abs(fft(X,N));
    
    %[pks,locs] = findpeaks(X,'MinPeakDistance',100);
    [pks,locs] = findpeaks(X);%,'Threshold',1)
   % cycles = diff(locs);
   % meanCycle = mean(cycles);

    figure
    subplot(2,1,1)
    plot(Time,X)%,Time(locs),pks,'or');
    xlabel('Time in Second')
    ylabel('Lengths in Byte')
    title('Time Domain')
    subplot(2,1,2)
    
    %yaxis = [0 30];
    plot(f, x_mags(1:N_2))%,1./[meanCycle meanCycle],yaxis)
    xlabel('Frequency in Hz')
    ylabel('Magnitude')
    title('Frequency Domain')

    [pk,MaxFreq] = findpeaks(x_mags(1:N_2),'NPeaks',1,'SortStr','descend');

    %Period = 1/f(MaxFreq)
    hold on
    plot(f(MaxFreq),pk,'or')
    hold off
    legend('Fourier transform','1/Period')
    y(:,1) = f';
    y(:,2) = x_mags(1:N_2);
end

