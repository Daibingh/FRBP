clc,clear all
clc,clear
% path = 'H:\FERET\colorferet\colorferet\dvd1\data\smaller\00000��ѹ';
path = 'F:\MATLAB\AAA����\face_detection\faces\all';
info = loadDatabase(path, @getID);

[info_train, info_test] = divideSet(info, @choose);