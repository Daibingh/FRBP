clc
clear all
img = imread('E:\matlab\aaaÂÛÎÄ\mulface2.jpg');
d = vision.CascadeObjectDetector();
bbox = step(d, img);
img2 = insertShape(img, 'rectangle', bbox, 'linewidth', 2.0);
% figure;
% imshow(img2);

[bbox_, faces, img_] = my_face_detector(img);
figure;
img_t = [img2, img_];
imshow(img_t);
