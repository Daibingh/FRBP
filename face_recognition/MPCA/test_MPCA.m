clc,clear all
close all
newSize=[10,10];
% path = 'H:\FERET\colorferet\colorferet\dvd1\data\smaller\00000解压';
% path = 'F:\MATLAB\Face_Image\face_1\all';
path = 'F:\MATLAB\AAA论文\face_database\ORL_40_10_112_92_pgm\all';

%加载人脸库并划分出训练集与测试集
databaseInfo = loadDatabase(path, @(in) in(1:3));
[trainInfo, testInfo] = divideSet(databaseInfo, @(in) in(1));

% % 训练
mpca_train(trainInfo, newSize, 36);
% % 测试
% [test_label, rate] = mpca_test('', testInfo.name_list, @eulerDis, testInfo.label_list);

% 测试单独一张
img = testInfo.name_list(2);
imgName = cell(1,1);
for i =1:length(imgName); imgName(i) = img;end
[label, ~] = mpca_test('', imgName, @eulerDis)