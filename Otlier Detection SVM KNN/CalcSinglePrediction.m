Facebookprd = [];
Facebooksnap = [];
for i = 1:9
    try
    Facebookprd = horzcat(Facebookprd,finaloutlierscoretest{i}(:,1));
    Facebooksnap = horzcat(Facebooksnap,finaloutlierscoresnap{i}(:,1));
    catch
        continue;
    end
end