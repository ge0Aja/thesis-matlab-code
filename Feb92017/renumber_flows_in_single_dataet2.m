single_user_labels = unique(all_plus_dos_plus_brows_en);

all_plus_dos_renumbered = [];
parfor i = 1 : size(single_user_labels,1)
    app_new = [];
    app = all_plus_dos_plus_brows_en(all_plus_dos_plus_brows_en(:,32) == single_user_labels(i),:);
    unique_app_flows = unique(app(:,31));
    l = 1 ;
    for j = 1 : size(unique_app_flows,1)
        unique_flow = app(app(:,31) == unique_app_flows(j),:);
        unique_flow(:,31) = l;
        app_new = vertcat(app_new,unique_flow);
        l = l +1;
    end
    all_plus_dos_renumbered = vertcat(all_plus_dos_renumbered,app_new);
end