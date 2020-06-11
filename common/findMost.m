function fm = findMost(row_cell)
%fm = findMost(row_cell)
%对一个行cell数组求众数，内容为字符串
id = cell(0);
for i=1:length(row_cell)
    if include(id, row_cell{i}) ==0
        id{length(id)+1} = row_cell{i};
    end
end
count = zeros(1,length(id));
max_count_index = 0;
max_count = 0;
for i=1:length(id)
    for j=1:length(row_cell)
        if strcmp(id{i},row_cell{j})
            count(i) = count(i) + 1;
        end
    end
    if count(i) > max_count
        max_count = count(i);
        max_count_index = i;
    end
end
fm = id{max_count_index};

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

