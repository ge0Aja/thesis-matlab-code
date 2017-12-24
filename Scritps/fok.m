% TPR = [];
% FPR = [];
% F1 = [];
% 
% for i =1:length(Fin2)
%     TPR = vertcat(TPR,Fin2{i}{1});
%     FPR = vertcat(FPR,Fin2{i}{2});
%     F1 = vertcat(F1,Fin2{i}{3});
% end


for i =1:length(Finss)
%     GTPR = [];
%     GFPR = [];
%     GF1 = [];
    BTPR = [];
    BFPR = [];
    BF1 = [];
%     KTPR = [];
%     KFPR = [];
%     KF1 = [];
    for j =1:30
       
%         GTPR = vertcat(GTPR,Finss{i}{j}{7});
%         GFPR = vertcat(GFPR,Finss{i}{j}{8});
%         GF1 = vertcat(GF1,Finss{i}{j}{9});
        BTPR = vertcat(BTPR,Finss{i}{j}{1});
        BFPR = vertcat(BFPR,Finss{i}{j}{2});
        BF1 = vertcat(BF1,Finss{i}{j}{3});
%         KTPR = vertcat(KTPR,Finss{i}{j}{4});
%         KFPR = vertcat(KFPR,Finss{i}{j}{5});
%         KF1 = vertcat(KF1,Finss{i}{j}{6});
    end
%     Group{i}{7} = GTPR;
%     Group{i}{8} = GFPR;
%     Group{i}{9} = GF1;
     Group{i}{1} = BTPR;
     Group{i}{2} = BFPR;
     Group{i}{3} = BF1;
%     Group{i}{4} = KTPR;
%     Group{i}{5} = KFPR;
%     Group{i}{6} = KF1;
end


TPR1 = [];
FPR1 = [];
F11 = [];
% TPR3 = [];
% FPR3 = [];
% F13 = [];
% TPR2 = [];
% FPR2 = [];
% F12 = [];
for i =1:length(Group)
     fprintf('check %d %d',i);
%  GTPR =  mean(Group{i}{7});
%  GFPR =  mean(Group{i}{8});
%  GF1 =  mean(Group{i}{9}); 
 BTPR =  mean(Group{i}{1});
 BFPR =  mean(Group{i}{2});
 BF1 =  mean(Group{i}{3});
%  KTPR =  mean(Group{i}{4});
%  KFPR =  mean(Group{i}{5});
%  KF1 =  mean(Group{i}{6});
 
%  TPR1 = vertcat(TPR1,GTPR);
%  FPR1 = vertcat(FPR1,GFPR);
%  F11 = vertcat(F11,GF1);
%  
 
%  TPR3 = vertcat(TPR2,KTPR);
%  FPR3 = vertcat(FPR2,KFPR);
%  F13 = vertcat(F12,KF1);

 TPR1 = vertcat(TPR1,BTPR);
 FPR1 = vertcat(FPR1,BFPR);
 F11 = vertcat(F11,BF1);
 
%  TPR2 = vertcat(TPR2,KTPR);
%  FPR2 = vertcat(FPR2,KFPR);
%  F12 = vertcat(F12,KF1);
%  
%  TPR3 = vertcat(TPR3,GTPR);
%  FPR3 = vertcat(FPR3,GFPR);
%  F13 = vertcat(F13,GF1);
end
 