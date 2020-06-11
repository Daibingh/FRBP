clc,clear
% path = 'F:\MATLAB\Face_Image\face_1\all';
% path = 'H:\FERET\colorferet\colorferet\dvd1\data\smaller\00000解压';
path = 'F:\MATLAB\AAA论文\face_database\face_40_6_480_640_jpg\face1\all';
list = getFileList_(path);

% k = 1;
% for i=1:length(list)
%     img = imread([path, filesep, list{i}]);
%     img = imresize(img,[50,50]);
%     % img=imread('mulface4.jpg');
%     [face_box, faces, img] = my_face_detector(img);
%     for j=1:length(faces)
%         imwrite(faces{j}, ['./faces2/',list{i}]);
%         disp(['已保存第 ', num2str(k), ' 张图片！']);
%         k = k + 1;
%     end
% end

% img = imread([path,filesep,list{2}]);
img=imread('E:\MATLAB\Face_Image\face_my\mulface1.jpg');
[face_box, faces, img] = my_face_detector(img);
imshow(img);