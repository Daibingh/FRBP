clc,clear all
close all
newSize=[50,50];
% path = 'H:\FERET\colorferet\colorferet\dvd1\data\smaller\00000��ѹ';
path = 'E:\MATLAB\AAA����\face_database\face_40_6_480_640_jpg\face1\all';
% path = 'F:\MATLAB\AAA����\face_detection\faces\all';
% path = 'F:\MATLAB\AAA����\face_database\FERET_200_7_80_80_tif\all';
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
% ������ԭͼ���� ��������ͶӰ��������Ա�
% l=22; %Ҫ�ȶԵڼ���
% %��ʾһ������ԭͼ��
% i1=imread(trainImageNameList{l});
% i1=rgb2gray(i1);
% figure;
% imshow(i1);
% %����������ͶӰ��ȥ
% load pca_data;
% zeroMeanTrainSamples2=trainNew*T'; %��������ͶӰ�õ����ֵ������
% trainSamples2=zeroMeanTrainSamples2+repmat(trainSamplesMean,size(zeroMeanTrainSamples2,1),1); %���Ͼ�ֵ
% i2=reshape(trainSamples2(l,:)',newSize(1),newSize(2)); %��ԭΪ����
% i2=imresize(i2,originSize); %��ԭΪԭʼͼ��ߴ�
% figure;
% imshow(i2);



