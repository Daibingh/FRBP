function pca_train(trainInfo, newSize, lm_num, filename)
% pca_train(trainInfo, newSize, lm_num, filename)

%调用子函数，准备数据矩阵
[x, oldSize]=arrDataMat(trainInfo.name_list, newSize);
%调用子函数，进行PCA，求投影方向和主成分
if lm_num <= 0 || lm_num > min(size(x, 1),size(x, 2))
    lm_num = min(size(x, 1),size(x, 2)) - 1;
    disp(['pca_train: set lm_num to ', num2str(lm_num), ' ！']);
end

[T, y_train, x_mean_train] = my_pca(x, lm_num);
%求平均脸
meanFace = reshape(x_mean_train',newSize(1),newSize(2));

% figure;
% meanFaceOldSize = imresize(meanFace, oldSize);
% imshow(meanFaceOldSize); %显示平均脸
% title('Mean face of the training samples');

train_label = trainInfo.label_list;
if nargin ==3
    filename = 'pca_data';
end
save(filename, 'train_label', 'newSize', 'x_mean_train', 'oldSize', 'T', 'y_train');
end