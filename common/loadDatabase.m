function info = loadDatabase(path, getID)
% info = loadDatabase(path, getID)
info = struct('name_list',[],'label_list',[],'id_list',[],'id_mat',[],'C',[],'Ni',[],'N',[]);
l = getFileList(path,'s');
info.N = length(l);
lab = cell(info.N,1);
info.id_list = cell(0);
for i=1:info.N
    lab{i} = getID(l{i});
    if include(info.id_list, lab{i}) == 0
        info.id_list{length(info.id_list)+1} = lab{i};
    end   
end
info.id_list = (info.id_list)';
info.name_list = cell(info.N,1);
info.label_list = cell(info.N,1);
info.C = length(info.id_list);
k=1;
info.Ni = zeros(info.C,1);
info.id_mat = cell(info.C,1);
for i=1:info.C
    t = 1;
    for j=1:info.N
        if strcmp(lab{j},info.id_list{i})
            info.Ni(i) = info.Ni(i) + 1;
            info.label_list{k} = lab{j};
            info.name_list{k} = [path, filesep, l{j}]; 
            info.id_mat{i}(t) = k;
            k=k+1;
            t=t+1;
        end
    end
end


function f = include(A, a)
    n_in = length(A);
    if n_in == 0
       f = 0;
       return;
    end
    for i_in =1:n_in
        if strcmp(a ,A{i_in})
            f = 1;
            return;
        end
    end
    f = 0;
end

end


