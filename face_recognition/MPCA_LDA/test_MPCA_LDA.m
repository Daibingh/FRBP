clc,clear all
close all
newSize=[10,10];
% path = 'H:\FERET\colorferet\colorferet\dvd1\data\smaller\00000��ѹ';
% path = 'F:\MATLAB\Face_Image\face_1\all';
path = 'F:\MATLAB\AAA����\face_database\face_40_6_480_640_jpg\face1_detected\all';

%���������Ⲣ���ֳ�ѵ��������Լ�
databaseInfo = loadDatabase(path, @getID);
[trainInfo, testInfo] = divideSet(databaseInfo, @choose);

% ѵ��
mpca_lda_train(trainInfo, newSize, 42);
% ����
% [test_label, rate] = mpca_lda_test(testInfo.name_list, @eulerDis, testInfo.label_list);
close all