function [samples, oldSize]=arrDataMat(imageNameList, newSize)        
%[samples, oldSize]=arrDataMat(imageNameList, newSize) 

img = imread(imageNameList{1});
oldSize = size(img);
oldSize = oldSize(1:2);
clear img;
if nargin == 1
    newSize = oldSize;
end
rowNum = size(imageNameList,1); %rowNum:������
rolNum=newSize(1)*newSize(2); %ԭʼά��
samples = zeros(rowNum, rolNum);

%׼����������
 for k=1:rowNum
     imageTemp_ = imread(imageNameList{k});
     imageTemp = im2double(imageTemp_);
     if length(size(imageTemp))==3
        imageTemp = rgb2gray(imageTemp); %�ҶȻ�
        imageTemp = histeq(imageTemp); %ֱ��ͼ���⻯
     end
    imageTemp2 = imresize(imageTemp, newSize);
    imageTemp3  = imageTemp2(:)';
    samples(k,:) = imageTemp3;
 end
end