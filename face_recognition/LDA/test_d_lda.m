clc,clear all
close all
newSize=[10,10];
% path = 'H:\FERET\colorferet\colorferet\dvd1\data\smaller\00000��ѹ';
% path = 'F:\MATLAB\Face_Image\face_1\all';
path = 'F:\MATLAB\AAA����\face_detection\faces\all';

%���������Ⲣ���ֳ�ѵ��������Լ�
databaseInfo = loadDatabase(path, @getID);
[trainInfo, testInfo] = divideSet(databaseInfo, @choose);

% ѵ��
lda_train(trainInfo, newSize, 0);
% ����
[test_label, rate] = lda_test(testInfo.name_list, @eulerDis, testInfo.label_list);




