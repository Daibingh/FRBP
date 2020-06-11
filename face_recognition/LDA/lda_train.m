function lda_train(trainInfo, newSize, lm_num, filename)
% lda_train(trainInfo, newSize, lm_num, filename)

% 读取训练样本、测试样本图片，构成数据矩阵
[x_train, oldSize] = arrDataMat(trainInfo.name_list, newSize);

c = trainInfo.C;
ni = trainInfo.Ni;
if lm_num <= 0 || lm_num > min(size(x_train, 2), c)
    lm_num = min(size(x_train, 2), c) - 1;
    disp(['lda_train: set lm_num to ', num2str(lm_num), ' ！']);
end
[T, y_train, x_mean_train] = my_lda(x_train, c, ni, lm_num);

train_label = trainInfo.label_list;
if nargin ==3
    filename = 'lda_data';
end
save(filename, 'train_label', 'oldSize', 'newSize', 'T', 'y_train', 'x_mean_train');
end


