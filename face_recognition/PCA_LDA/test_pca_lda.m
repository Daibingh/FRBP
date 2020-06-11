clc,clear all
close all
newSize=[10,10];
% path = 'H:\FERET\colorferet\colorferet\dvd1\data\smaller\00000解压';
% path = 'F:\MATLAB\Face_Image\face_1\all';
path = 'F:\MATLAB\AAA论文\face_detection\faces\all';

%加载人脸库并划分出训练集与测试集
databaseInfo = loadDatabase(path, @getID);
[trainInfo, testInfo] = divideSet(databaseInfo, @choose);

% 训练
pca_lda_train(trainInfo, newSize, 42, 0);
% 测试
[test_label, rate] = pca_lda_test(testInfo.name_list, @eulerDis, testInfo.label_list);






