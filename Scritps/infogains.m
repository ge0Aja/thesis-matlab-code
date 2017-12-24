for i = 1 : 6
    for j = 1 : 4
        newmat = [];
        newmat = horzcat(newmat,twosec{i}{j}(:,12));
        newmat = horzcat(newmat,twosec{i}{j}(:,24));
        newmat = horzcat(newmat,twosec{i}{j}(:,13));
        newmat = horzcat(newmat,twosec{i}{j}(:,17));
        newmat = horzcat(newmat,twosec{i}{j}(:,20));
        newmat = horzcat(newmat,twosec{i}{j}(:,22));
        newmat = horzcat(newmat,twosec{i}{j}(:,19));
        newmat = horzcat(newmat,twosec{i}{j}(:,11));
        newmat = horzcat(newmat,twosec{i}{j}(:,18));
        newmat = horzcat(newmat,twosec{i}{j}(:,21));
        newmat = horzcat(newmat,twosec{i}{j}(:,25));
        newmat = horzcat(newmat,twosec{i}{j}(:,14));
        newmat = horzcat(newmat,twosec{i}{j}(:,2));
        newmat = horzcat(newmat,twosec{i}{j}(:,1));
        newmat = horzcat(newmat,twosec{i}{j}(:,4));
        newmat = horzcat(newmat,twosec{i}{j}(:,16));
        newmat = horzcat(newmat,twosec{i}{j}(:,23));
        newmat = horzcat(newmat,twosec{i}{j}(:,5));
        newmat = horzcat(newmat,twosec{i}{j}(:,12));
        
        newmat = horzcat(newmat,twosec{i}{j}(:,29));
            Newtwosec19 {i}{j} = newmat;
    end
end




AllTwoSecs {1} = Newtwosec19;
AllTwoSecs {2} = Newtwosec18;
AllTwoSecs {3} = Newtwosec17;
AllTwoSecs {4} = Newtwosec16;
AllTwoSecs {5} = Newtwosec15;
AllTwoSecs {6} = Newtwosec14;
AllTwoSecs {7} = Newtwosec13;
AllTwoSecs {8} = Newtwosec12;
AllTwoSecs {9} = Newtwosec11;
AllTwoSecs {10} = Newtwosec10;
AllTwoSecs {11} = Newtwosec9;
AllTwoSecs {12} = Newtwosec8;
AllTwoSecs {13} = Newtwosec7;
AllTwoSecs {14} = Newtwosec6;
AllTwoSecs {15} = Newtwosec5;
AllTwoSecs {16} = Newtwosec4;
AllTwoSecs {17} = Newtwosec3;
AllTwoSecs {18} = Newtwosec2;
AllTwoSecs {19} = Newtwosec1;



for i = 1 : 19
    for j = 1 : 4
        stsTpr  (j,:) = FinAllTwoSecs{i}{j,1};
        stsFpr  (j,:) = FinAllTwoSecs{i}{j,2};
    end
    
    meanFpr(i,:) = mean(stsFpr,1);
    meanTpr(i,:) = mean(stsTpr,1);
end

for i = 1 : 19
    meanFpr(i,:) = mean(stsFpr{i},1);
    meanTpr(i,:) = mean(stsTpr{i},1);
end