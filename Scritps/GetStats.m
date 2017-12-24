function [ stats ] = GetStats( Time,Length, Secs, Packetdir,thresh)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
TempPacketsIn = 0;
TempPacketsOut = 0;
TempBytesIn = 0;
TempBytesOut = 0;
TempTime = 0;
TimeBurstIn = 0;
TimeBurstOut = 0;
%CumTime = 0;
j=1;
m_in=1;
m_out=1;
for i=1:length(Secs)
    if(TempTime + Secs(i) <= thresh && i ~= length(Secs))
        if(Packetdir(i) == -1)
            TempPacketsOut = TempPacketsOut +1;
            TempBytesOut = TempBytesOut + Length(i);
            if(i == 1)
                TempSecsOut(1) = 0;
                TempLengthsOut(1) = Length(i);
                m_out = m_out +1;
            else
            TempSecsOut(m_out) = Time(i) - Time(i-1);
            TempLengthsOut(m_out) = Length(i);
            m_out = m_out +1;
            end
        else
            TempPacketsIn = TempPacketsIn +1;
            TempBytesIn = TempBytesIn + Length(i);
            if(i == 1)
                TempSecsIn(1) = 0;
                TempLengthsIn(1) = Length(i);
                m_in = m_in +1;
            else
            TempSecsIn(m_in) = Time(i) - Time(i-1);
            TempLengthsIn(m_in) = Length(i);
            m_in = m_in +1;
            end
        end
        
            TempTime = TempTime + Secs(i) ;
    else
            stats(j,1) = TempPacketsOut;
            stats(j,2) = TempPacketsIn;
            stats(j,3) = TempPacketsOut ./ TempPacketsIn;
            %stats(j,3) = TempPacketsOut + TempPacketsIn;
            stats(j,4) = TempBytesOut;
            stats(j,5) = TempBytesIn;
            stats(j,6) = TempBytesOut ./ TempBytesIn;
            try
            stats(j,7) = mean(diff(TempSecsIn));
            stats(j,8) = mean(diff(TempLengthsIn));
            catch
                stats(j,7) = NaN;
                stats(j,8) = NaN;
            end
            
            try
            stats(j,9) = mean(diff(TempSecsOut));
            stats(j,10) = mean(diff(TempLengthsOut)); 
            catch
                stats(j,9) = NaN;
                stats(j,10) = NaN;
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            try
            stats(j,19) = mean(TempSecsIn);
            stats(j,20) = mean(TempLengthsIn);
            catch
                stats(j,19) = NaN;
                stats(j,20) = NaN;
            end
            
            try
            stats(j,21) = mean(TempSecsOut);
            stats(j,22) = mean(TempLengthsOut); 
            catch
                stats(j,21) = NaN;
                stats(j,22) = NaN;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            try
            stats(j,11) = median(TempSecsIn);
            stats(j,12) = median(TempLengthsIn);
            catch
                stats(j,11)= NaN;
                stats(j,12)= NaN;
            end
            
            try
            stats(j,13) = median(TempSecsOut);
            stats(j,14) = median(TempLengthsOut);
            catch
                stats(j,13) = NaN;
                stats(j,14) = NaN;
            end
            
            try
            stats(j,15) = var(diff(TempSecsIn));
            stats(j,16) = var(diff(TempLengthsIn));
            catch
                stats(j,15) = NaN;
                stats(j,16) = NaN;
            end
            
            try
            stats(j,17) = var(diff(TempSecsOut));
            stats(j,18) = var(diff(TempLengthsOut));
            catch
                stats(j,17) = NaN;
                stats(j,18) = NaN;
            end
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            try
            stats(j,23) = var(TempSecsIn);
            stats(j,24) = var(TempLengthsIn);
            catch
                stats(j,23) = NaN;
                stats(j,24) = NaN;
            end
            
            try
            stats(j,25) = var(TempSecsOut);
            stats(j,26) = var(TempLengthsOut);
            catch
                stats(j,25) = NaN;
                stats(j,26) = NaN;
            end
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            
            stats(j,27) = TimeBurstIn;
            stats(j,28) = TimeBurstOut;
            %% added this section for the flow length
%             try
%             stats(j,29) = sum(TempSecsOut);
%             catch
%                 stats(j,29) = 0;
%             end
%             
%             try
%             stats(j,30) = sum(TempSecsIn);
%             catch
%                 stats(j,30) = 0;
%             end
            %%
            %stats(j,19) = TempBytesOut + TempBytesIn ; 
            %stats(j,20) = CumTime;
            j = j+1;
            m_in=1;
            m_out=1;
            TempPacketsOut = 0;
            TempPacketsIn = 0;
            TempBytesOut = 0;
            TempBytesIn = 0;
            TempSecsOut = [];
            TempSecsIn = [];
            TempLengthsOut = [];
            TempLengthsIn = [];
            TempTime = 0;
            TimeBurstIn = 0;
            TimeBurstOut = 0;

             if(Packetdir(i) == -1)
                TempPacketsOut = TempPacketsOut +1;
                TempBytesOut = TempBytesIn + Length(i); 
                TempSecsOut(m_out) = Time(i) - Time(i-1);
                TempLengthsOut(m_out) = Length(i);
                m_out = m_out +1;
                TimeBurstOut =Secs(i);
            else
                TempPacketsIn = TempPacketsIn +1;
                TempBytesIn = TempBytesOut + Length(i);
                TempSecsIn(m_in) = Time(i) - Time(i-1);
                TempLengthsIn(m_in) = Length(i);
                m_in = m_in +1;
                TimeBurstIn = Secs(i);
             end

            TempTime = TempTime + Secs(i);
            
    end
         %CumTime = CumTime + Secs(i);
end

end

