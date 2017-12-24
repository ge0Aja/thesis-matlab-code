tic
parfor i = 1 : 9
    tic
    Data{i} = load(Names{i});
    Stats{i} = OneClickPar( 1500000,2,2,10, Data{i}.(Names{i}),IPs{i},Labels)
    fprintf('\n\n  User %d Finished \n\n',i)
    toc
end
toc

save('Stats2SecondsNewFlowPreprocessingMarch102017.mat','Stats')
clear Data