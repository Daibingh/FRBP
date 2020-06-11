clc
clear all
d = vision.CascadeObjectDetector('ClassificationModel', 'FrontalFaceCART');
img = imread('E:\MATLAB\AAAÂÛÎÄ\mulface1.jpg');
bbox = step(d, img);
img1 = insertShape(img, 'rectangle', bbox(1,:));
imshow(img1)