clc,clear all
clc,clear
% path = 'H:\FERET\colorferet\colorferet\dvd1\data\smaller\00000½âÑ¹';
path = 'F:\MATLAB\AAAÂÛÎÄ\face_detection\faces\all';
info = loadDatabase(path, @getID);

[info_train, info_test] = divideSet(info, @choose);