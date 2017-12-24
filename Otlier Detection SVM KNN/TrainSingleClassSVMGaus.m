function [ Return ] = TrainSingleClassSVMGaus( Dataset,Snap )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    parfor i = 1 : 6
        classtrainid = (Dataset{1}(:,end) == i);
        classtestind = (Dataset{2}(:,end) == i);
        if(sum(classtestind) ~= 0)
        Classifeir = fitcsvm(Dataset{1}(classtrainid,1:28),Dataset{1}(classtrainid,end),...
            'KernelFunction','gaussian',...
            'KernelScale','Auto',...
            'BoxConstraint',1,...
            'Standardize',true);
        [~,Return{i}{1}] = predict(Classifeir,Dataset{2}(classtestind,1:28));
        [~,Return{i}{2}] = predict(Classifeir,Snap(:,1:28));
        end
         
    end
       
end

