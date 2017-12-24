function [ Stats ] = GetFlowTimeStats( X )
%UNTITLED19 Summary of this function goes here
%   Detailed explanation goes here

n = length(X);
FCount = 0; FInSum = 0 ; FOutSum = 0; FInOutSum = 0 ; FinMean = 0; FOutMean = 0; 
GCount = 0; GInSum = 0 ; GOutSum = 0; GInOutSum = 0 ;
SCount = 0; SInSum = 0 ; SOutSum = 0; SInOutSum = 0 ;
VCount = 0; VInSum = 0 ; VOutSum = 0; VInOutSum = 0 ;
WCount = 0; WInSum = 0 ; WOutSum = 0; WInOutSum = 0 ;
YCount = 0; YInSum = 0 ; YOutSum = 0; YInOutSum = 0 ;

for i=1:n
    switch(X(i,6))
        case 1
            FCount = FCount + 1;
            FInSum = FInSum + X(i,1);
            FOutSum = FOutSum + X(i,2);
            FInOutSum = FInOutSum + X(i,3);
        case 2
            GCount = GCount + 1;
            GInSum = GInSum + X(i,1);
            GOutSum = GOutSum + X(i,2);
            GInOutSum = GInOutSum + X(i,3);
        case 3
            SCount = SCount + 1;
            SInSum = SInSum + X(i,1);
            SOutSum = SOutSum + X(i,2);
            SInOutSum = SInOutSum + X(i,3);
        case 4
            VCount = VCount + 1;
            VInSum = VInSum + X(i,1);
            VOutSum = VOutSum + X(i,2);
            VInOutSum = VInOutSum + X(i,3);
        case 5
            WCount = WCount + 1;
            WInSum = WInSum + X(i,1);
            WOutSum = WOutSum + X(i,2);
            WInOutSum = WInOutSum + X(i,3);
        case 6
            YCount = YCount + 1;
            YInSum = YInSum + X(i,1);
            YOutSum = YOutSum + X(i,2);
            YInOutSum = YInOutSum + X(i,3);
    end
end
Stats(1,:) = [FCount FInSum FOutSum FInOutSum];
Stats(2,:) = [GCount GInSum GOutSum GInOutSum];
Stats(3,:) = [SCount SInSum SOutSum SInOutSum];
Stats(4,:) = [VCount VInSum VOutSum VInOutSum];
Stats(5,:) = [WCount WInSum WOutSum WInOutSum];
Stats(6,:) = [YCount YInSum YOutSum YInOutSum];
end

