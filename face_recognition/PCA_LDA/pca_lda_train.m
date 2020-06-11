function pca_lda_train(trainInfo, newSize, lm_num1, lm_num2, filename)
% pca_lda_train(trainInfo, train_label, newSize, lm_num1, lm_num2, filename)

% 读取训练样本、测试样本图片，构成数据矩阵
[x_train, oldSize] = arrDataMat(trainInfo.name_list, newSize);

n = trainInfo.N;
c = trainInfo.C;
ni = trainInfo.Ni;

if lm_num2 <= 0 || lm_num2 >= c
    lm_num2 = c-1;
    disp(['pca_lda_train: set lm_num2 to ', num2str(lm_num2), ' ！']);
end
if lm_num1 <= 0 || lm_num1 > min(size(x_train, 2), size(x_train, 1))
    lm_num1 = min(size(x_train, 2), size(x_train, 1)) - 1;
    disp(['pca_lda_train: set lm_num1 to ', num2str(lm_num1), ' ！']);
end
if lm_num1 < lm_num2 
    lm_num2 = lm_num1-1;
    disp(['pca_lda_train: set lm_num2 to ', num2str(lm_num2), ' ！']);
end

[T, y_train, x_mean_train] = my_pca_lda(x_train, c, ni, lm_num1, lm_num2);

train_label = trainInfo.label_list;
if nargin ==4
    filename = 'pca_lda_data';
end
save(filename, 'train_label', 'oldSize', 'newSize', 'T', 'y_train', 'x_mean_train');
end