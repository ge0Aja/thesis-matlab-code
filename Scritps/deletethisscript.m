myCluster = parcluster();
tic
myJob = batch(myCluster, @OneClickPar, 1, {1500,1500,1500,4,Serovpe,'192.168.137.12'}, 'Pool', 5, 'CurrentDirectory', '.');
%myJob = batch(myCluster, @OneClickPar, 1, {SerovpeFlows,2}, 'Pool', 5, 'CurrentDirectory', '.');
wait(myJob);
fprintf('Finished all the users');
toc
output = fetchOutputs(myJob);