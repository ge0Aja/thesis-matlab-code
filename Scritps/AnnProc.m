    function [acc,tpr,fpr,f1] = AnnProc( traindata,testdata,hiddenlayerscount,hiddenlayers,transfcn,perffcn,trainfcn,alpha )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
% n = length(Folds);
% for k=1:n
% %Transpose both vectors to be used by the ANN classifier
% testdatat = Folds{k,1}';
% traindatat = Folds{k,3}';
% traindatat = 
% trainlabel = Folds{k,4};
% testlabel = Folds{k,2};
 traindatat = traindata(:,1:28)';
 testdatat = testdata(:,1:28)';
 
% %transform the label vector for training and testing to a m x n matrix where m is the number of
% %instances and n is the number of classes
% testtargets =[];
% testargets = [];

trainlabels = traindata(:,end);
testlabel = testdata(:,end);
% for i=1:length(traindatat)
%     if(trainlabel(i) == 1)
%     testtargets(i,1) = 1;
%     else
%         testtargets(i,2) = 1;
%     end
% end

for i=1:length(trainlabels)
    switch trainlabels(i)
        case 1 
            traintargets(i,1) = 1;
        case 2
            traintargets(i,2) = 1;
        case 3
            traintargets(i,3) = 1;
        case 4
            traintargets(i,4) = 1;
        case 5 
            traintargets(i,5) = 1;
        case 6
            traintargets(i,6) = 1;
    end
end

for i=1:length(testlabel)
    switch testlabel(i)
        case 1 
            testtargets(i,1) = 1;
        case 2
            testtargets(i,2) = 1;
        case 3
            testtargets(i,3) = 1;
        case 4
            testtargets(i,4) = 1;
        case 5 
            testtargets(i,5) = 1;
        case 6
            testtargets(i,6) = 1;
    end
end
% for i=1:length(testdatat)
%     if(testlabel(i) == 1)
%     testargets(1,i) = 1;
%     else
%         testargets(2,i) = 1;
%     end
% end

 testtargets = testtargets';
 traintargets = traintargets';

% a switch to create the network with the specified number of hidden layers
% and neurons 
switch hiddenlayerscount
    case 1
       net = patternnet([hiddenlayers]);
    case 2
        net = patternnet([hiddenlayers hiddenlayers]);
    case 3
        net = patternnet([hiddenlayers hiddenlayers hiddenlayers]);
    case 4
        net = patternnet([hiddenlayers hiddenlayers hiddenlayers hiddenlayers]);
end
%set the transfer function (activation function) 
%for each layer in the neural network
for j=1:hiddenlayerscount
net.layers{j}.transferFcn = transfcn;
end
%set the performance function (cost function).
net.performFcn = perffcn;
%set the training function for example gradient descent
net.trainFcn = trainfcn;
% set the learning rate 
net.trainParam.lr = alpha;
% view the network
%net.view;
%train the network using the train data where tr is training curves
net = train(net,traindatat,traintargets);
%classify test data using the trained NN
outputs = net(testdatat);
%
newout= vec2ind(outputs);
%
%perfout = outputs';
%calculate the performance using perform
%performance = perform(net,testargets,perfout);
%plot the learning curves
%figure, plotperform(tr);
%plot the confusion matrix
%figure, plotconfusion(testargets,outputs);
conf = confusionmat(newout,vec2ind(testtargets));
[tpr,fpr,f1] = CalcTRPFPR(conf);
acc = 100*sum(newout==vec2ind(testtargets))/size(newout,2);
end

