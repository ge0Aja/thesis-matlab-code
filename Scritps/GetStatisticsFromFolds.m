function [ Statistics ] = GetStatisticsFromFolds( CellData )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

for i=1:9
FCounter =0; FCounterPacketsOut =0;FCounterPacketsIn =0; FCounterBytesOut =0; FCounterBytesIn =0;
GCounter = 0; GCounterPacketsOut =0;GCounterPacketsIn =0; GCounterBytesOut =0; GCounterBytesIn =0;
SCounter = 0; SCounterPacketsOut =0;SCounterPacketsIn =0; SCounterBytesOut =0; SCounterBytesIn =0;
VCounter = 0; VCounterPacketsOut =0;VCounterPacketsIn =0; VCounterBytesOut =0;VCounterBytesIn =0;
WCounter = 0; WCounterPacketsOut =0; WCounterPacketsIn =0; WCounterBytesOut =0; WCounterBytesIn =0;
YCounter = 0; YCounterPacketsOut =0;YCounterPacketsIn =0; YCounterBytesOut =0; YCounterBytesIn =0;
    for j = 1:length(CellData{i})
        switch CellData{i}(j,end)
            case 1
                FCounter = FCounter +1;
                FCounterPacketsOut = FCounterPacketsOut + CellData{i}(j,1);
                FCounterPacketsIn = FCounterPacketsIn +  CellData{i}(j,2);
                FCounterBytesOut = FCounterBytesOut + CellData{i}(j,4);
                FCounterBytesIn = FCounterBytesIn + CellData{i}(j,5);
            case 2
                SCounter = SCounter +1;
                SCounterPacketsOut = SCounterPacketsOut + CellData{i}(j,1);
                SCounterPacketsIn = SCounterPacketsIn +  CellData{i}(j,2);
                SCounterBytesOut = SCounterBytesOut + CellData{i}(j,4);
                SCounterBytesIn = SCounterBytesIn + CellData{i}(j,5);
            case 3
                GCounter = GCounter +1;
                GCounterPacketsOut = GCounterPacketsOut + CellData{i}(j,1);
                GCounterPacketsIn = GCounterPacketsIn +  CellData{i}(j,2);
                GCounterBytesOut = GCounterBytesOut + CellData{i}(j,4);
                GCounterBytesIn = GCounterBytesIn + CellData{i}(j,5);    
            case 4
                VCounter = VCounter +1;
                VCounterPacketsOut = VCounterPacketsOut + CellData{i}(j,1);
                VCounterPacketsIn = VCounterPacketsIn +  CellData{i}(j,2);
                VCounterBytesOut = VCounterBytesOut + CellData{i}(j,4);
                VCounterBytesIn = VCounterBytesIn + CellData{i}(j,5); 
            case 5
                WCounter = WCounter +1;
                WCounterPacketsOut = WCounterPacketsOut + CellData{i}(j,1);
                WCounterPacketsIn = WCounterPacketsIn +  CellData{i}(j,2);
                WCounterBytesOut = WCounterBytesOut + CellData{i}(j,4);
                WCounterBytesIn = WCounterBytesIn + CellData{i}(j,5);  
            case 6
                YCounter = YCounter +1;
                YCounterPacketsOut = YCounterPacketsOut + CellData{i}(j,1);
                YCounterPacketsIn = YCounterPacketsIn +  CellData{i}(j,2);
                YCounterBytesOut = YCounterBytesOut + CellData{i}(j,4);
                YCounterBytesIn = YCounterBytesIn + CellData{i}(j,5);
        end
    end
    Statistics{i,1} = [FCounter FCounterPacketsOut FCounterPacketsIn FCounterBytesOut FCounterBytesIn];
    Statistics{i,2} = [GCounter GCounterPacketsOut GCounterPacketsIn GCounterBytesOut GCounterBytesIn];
    Statistics{i,3} = [SCounter SCounterPacketsOut SCounterPacketsIn SCounterBytesOut SCounterBytesIn];
    Statistics{i,4} = [VCounter VCounterPacketsOut VCounterPacketsIn VCounterBytesOut VCounterBytesIn];
    Statistics{i,5} = [WCounter WCounterPacketsOut WCounterPacketsIn WCounterBytesOut WCounterBytesIn];
    Statistics{i,6} = [YCounter YCounterPacketsOut YCounterPacketsIn YCounterBytesOut YCounterBytesIn];
end
                

end

