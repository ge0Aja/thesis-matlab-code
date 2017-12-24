function [ stats ] = TempStatsCalculator( Time,Length, Secs, Packetdir,thresh )
%UNTITLED15 Summary of this function goes here
%   Detailed explanation goes here
TempTime = 0;
TimeBurstIn = 0;
TimeBurstOut = 0;
%CumTime = 0;
j=1;
m_in=1;
m_out=1;
for i=1:length(Secs)
    if( i ~= length(Secs)) %TempTime + Secs(i) <= thresh &&
        if(Packetdir(i) == -1)
       %     TempPacketsOut = TempPacketsOut +1;
       %     TempBytesOut = TempBytesOut + Length(i);
            if(i == 1)
                TempSecsOut(1) = 0;
       %         TempLengthsOut(1) = Length(i);
                m_out = m_out +1;
            else
            TempSecsOut(m_out) = Time(i) - Time(i-1);
       %     TempLengthsOut(m_out) = Length(i);
            m_out = m_out +1;
            end
        else
       %     TempPacketsIn = TempPacketsIn +1;
       %     TempBytesIn = TempBytesIn + Length(i);
            if(i == 1)
                TempSecsIn(1) = 0;
       %         TempLengthsIn(1) = Length(i);
                m_in = m_in +1;
            else
            TempSecsIn(m_in) = Time(i) - Time(i-1);
       %     TempLengthsIn(m_in) = Length(i);
            m_in = m_in +1;
            end
        end
        
            TempTime = TempTime + Secs(i) ;
    else
        try
        stats(j,1) = sum(TempSecsIn);
        catch
            stats(j,1) = NaN;
        end
       
        try
        stats(j,2) = sum(TempSecsOut);
        catch
            stats(j,2) = NaN;
        end
        
        try
        stats(j,3) =  sum(TempSecsIn) + sum(TempSecsOut);
        catch
            stats(j,3) = NaN;
        end
        
        stats(j,4) = TimeBurstIn;
        stats(j,5) = TimeBurstOut;
        j = j+1;
            m_in=1;
            m_out=1;
         
            TempSecsOut = [];
            TempSecsIn = [];
            TempTime = 0;
            TimeBurstIn = 0;
            TimeBurstOut = 0;

             if(Packetdir(i) == -1)
        %        TempPacketsOut = TempPacketsOut +1;
        %        TempBytesOut = TempBytesIn + Length(i); 
                TempSecsOut(m_out) = Time(i) - Time(i-1);
        %        TempLengthsOut(m_out) = Length(i);
                m_out = m_out +1;
                TimeBurstOut =Secs(i);
            else
        %        TempPacketsIn = TempPacketsIn +1;
        %        TempBytesIn = TempBytesOut + Length(i);
                TempSecsIn(m_in) = Time(i) - Time(i-1);
        %        TempLengthsIn(m_in) = Length(i);
                m_in = m_in +1;
                TimeBurstIn = Secs(i);
             end
    
            TempTime = TempTime + Secs(i);
            
    end
end

end

