function [  ] = p( X )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
figure
m=1;
for i=1:length(X)
        subplot(11,6,m)
        plot(abs(fft(diff(X{i}(:,3)),5000)))
        m(m<length(X))=m+1;
end

end

