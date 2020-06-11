clc
clear all
path = 'E:\MATLAB\AAA论文\face_database\ORL_40_10_112_92_pgm\ORL';
% path = 'F:\MATLAB\AAA论文\face_database\face_40_6_480_640_jpg\face1_detected\all';
info = loadDatabase(path, @(in) in(1:3));
[trainInfo, testInfo] = divideSet(info, @(in) in(1));

method = 'pca';
params.lm_num = 0;
params.lm_num1 =0;
params.lm_num2 =0;
params.p =0;
params.newSize = [15 15];
proj_train(trainInfo, method, params);
[test_label, rate] = proj_test(method, '', testInfo.name_list, @eulerDis, testInfo.label_list);