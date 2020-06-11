function [samples, oldSize]=arrDataMat2D(imageNameList, newSize)        
%[samples, oldSize]=arrDataMat2D(imageNameList, newSize)

img = imread(imageNameList{1});
oldSize = size(img);
oldSize = oldSize(1:2);
clear img;
if nargin == 1
    newSize = oldSize;
end
N = length(imageNameList);
rowNum = newSize(1); %rowNum:样本数
rolNum=newSize(2); %原始维度
samples = zeros(rowNum, rolNum, N);

%准备样本矩阵
 for k=1:N
     imageTemp = imread(imageNameList{k});
     imageTemp = im2double(imageTemp);
     if length(size(imageTemp))==3
        imageTemp = rgb2gray(imageTemp); %灰度化
        imageTemp = histeq(imageTemp); %直方图均衡化
     end
    imageTemp2 = imresize(imageTemp, newSize);
%     imageTemp3  = imageTemp2(:)';
    samples(:,:,k) = imageTemp2;
 end
end