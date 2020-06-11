clc,clear all
close all
newSize=[50,50];
% path = 'H:\FERET\colorferet\colorferet\dvd1\data\smaller\00000解压';
path = 'E:\MATLAB\AAA论文\face_database\face_40_6_480_640_jpg\face1\all';
% path = 'F:\MATLAB\AAA论文\face_detection\faces\all';
% path = 'F:\MATLAB\AAA论文\face_database\FERET_200_7_80_80_tif\all';
databaseInfo = loadDatabase(path, @(in) in(1:2));

[trainInfo, testInfo] = divideSet(databaseInfo, @(in) in(1));
pca_train(trainInfo, newSize, 0);

% i=1;
% for k=1199:1199
%     pca_train(trainInfo, newSize, k);
%     [test_label, rate] = pca_test(testInfo.name_list, '',@eulerDis, testInfo.label_list);
% %     data(i,:)=[k, rate];
%     i=i+1;
% end
% plot(data(1,:),data(2,:));
% 将人脸原图像与 特征脸反投影后的人脸对比
% l=22; %要比对第几张
% %显示一张人脸原图像
% i1=imread(trainImageNameList{l});
% i1=rgb2gray(i1);
% figure;
% imshow(i1);
% %将特征脸反投影回去
% load pca_data;
% zeroMeanTrainSamples2=trainNew*T'; %特征脸反投影得到零均值的人脸
% trainSamples2=zeroMeanTrainSamples2+repmat(trainSamplesMean,size(zeroMeanTrainSamples2,1),1); %加上均值
% i2=reshape(trainSamples2(l,:)',newSize(1),newSize(2)); %还原为矩阵
% i2=imresize(i2,originSize); %还原为原始图像尺寸
% figure;
% imshow(i2);



