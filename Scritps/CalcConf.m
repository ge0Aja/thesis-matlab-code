function [ Conf ] = CalcConf( res,TestClasses )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

Conf = zeros(6,6);

for i=1:length(TestClasses)
    switch(TestClasses(i))
        case 1
            switch(res(i))
                case 1
                    Conf(1,1) = Conf(1,1) +1;
                case 2
                    Conf(1,2) = Conf(1,2) +1;
                case 3
                    Conf(1,3) = Conf(1,3) +1;
                case 4
                    Conf(1,4) = Conf(1,4) +1;
                case 5
                    Conf(1,5) = Conf(1,5) +1;
                case 6
                    Conf(1,6) = Conf(1,6) +1;
            end
        case 2
            switch(res(i))
                case 1
                    Conf(2,1) = Conf(2,1) +1;
                case 2
                    Conf(2,2) = Conf(2,2) +1;
                case 3
                    Conf(2,3) = Conf(2,3) +1;
                case 4
                    Conf(2,4) = Conf(2,4) +1;
                case 5
                    Conf(2,5) = Conf(2,5) +1;
                case 6
                    Conf(2,6) = Conf(2,6) +1;
            end
        case 3
             switch(res(i))
                case 1
                    Conf(3,1) = Conf(3,1) +1;
                case 2
                    Conf(3,2) = Conf(3,2) +1;
                case 3
                    Conf(3,3) = Conf(3,3) +1;
                case 4
                    Conf(3,4) = Conf(3,4) +1;
                case 5
                    Conf(3,5) = Conf(3,5) +1;
                case 6
                    Conf(3,6) = Conf(3,6) +1;
             end
        case 4
             switch(res(i))
                case 1
                    Conf(4,1) = Conf(4,1) +1;
                case 2
                    Conf(4,2) = Conf(4,2) +1;
                case 3
                    Conf(4,3) = Conf(4,3) +1;
                case 4
                    Conf(4,4) = Conf(4,4) +1;
                case 5
                    Conf(4,5) = Conf(4,5) +1;
                case 6
                    Conf(4,6) = Conf(4,6) +1;
             end
        case 5
             switch(res(i))
                case 1
                    Conf(5,1) = Conf(5,1) +1;
                case 2
                    Conf(5,2) = Conf(5,2) +1;
                case 3
                    Conf(5,3) = Conf(5,3) +1;
                case 4
                    Conf(5,4) = Conf(5,4) +1;
                case 5
                    Conf(5,5) = Conf(5,5) +1;
                case 6
                    Conf(5,6) = Conf(5,6) +1;
             end
         case 6
             switch(res(i))
                case 1
                    Conf(6,1) = Conf(6,1) +1;
                case 2
                    Conf(6,2) = Conf(6,2) +1;
                case 3
                    Conf(6,3) = Conf(6,3) +1;
                case 4
                    Conf(6,4) = Conf(6,4) +1;
                case 5
                    Conf(6,5) = Conf(6,5) +1;
                case 6
                    Conf(6,6) = Conf(6,6) +1;
             end
    end

end

