function [samples, oldSize]=arrDataMat(imageNameList, newSize)        
%[samples, oldSize]=arrDataMat(imageNameList, newSize) 

img = imread(imageNameList{1});
oldSize = size(img);
oldSize = oldSize(1:2);
clear img;
if nargin == 1
    newSize = oldSize;
end
rowNum = size(imageNameList,1); %rowNum:样本数
rolNum=newSize(1)*newSize(2); %原始维度
samples = zeros(rowNum, rolNum);

%准备样本矩阵
 for k=1:rowNum
     imageTemp_ = imread(imageNameList{k});
     imageTemp = im2double(imageTemp_);
     if length(size(imageTemp))==3
        imageTemp = rgb2gray(imageTemp); %灰度化
        imageTemp = histeq(imageTemp); %直方图均衡化
     end
    imageTemp2 = imresize(imageTemp, newSize);
    imageTemp3  = imageTemp2(:)';
    samples(k,:) = imageTemp3;
 end
end