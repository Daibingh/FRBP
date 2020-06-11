function [info_train, info_test] = divideSet(info, choose)
%[info_train, info_test] = divideSet(info, choose)

info_train = struct('name_list',[],'label_list',[],'id_list',[],'id_mat',[],'C',[],'Ni',[],'N',[]);
info_test = struct('name_list',[],'label_list',[],'id_list',[],'id_mat',[],'C',0,'Ni',[],'N',0);

info_train = info;
tt_all = [];
for i=1:info.C
    tt = choose(info.id_mat{i});
    if isempty(tt);
        continue;
    end
    tt_n = length(tt);
    if tt_n >= length(info.id_mat{i})
        disp('选出的元素过多！');
        return;
    end
    info_train.N = info_train.N - tt_n;
    info_train.Ni(i) = info_train.Ni(i) - tt_n;
    info_test.N = info_test.N + tt_n;
    info_test.Ni(i,1) = tt_n;
    info_test.C = info_test.C + 1;
    info_test.name_list = [info_test.name_list; info.name_list(tt,:)];
    info_test.label_list = [info_test.label_list; info.label_list(tt,:)];
    tt_all = [tt_all;tt];
end
 info_train.name_list(tt_all,:) = [];
 info_train.label_list(tt_all,:) = [];
 info_train.id_mat = [];
end