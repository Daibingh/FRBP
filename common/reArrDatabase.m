function info = reArrDatabase(info)
% info2 = reArrDatabase(info)
nameList = info.name_list;
labelList = info.label_list;
info.N = length(nameList);
info.id_list = unique(labelList);
info.C = length(info.id_list);
index = 1:info.N;
info.Ni = zeros(info.C,1);
info.id_mat = cell(info.C,1);
for i=1:info.C
    mark = ismember(labelList, info.id_list{i});
    info.id_mat{i} = index(mark);
    info.Ni(i) = length(info.id_mat{i});
end
end