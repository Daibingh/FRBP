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
rowNum = newSize(1); %rowNum:������
rolNum=newSize(2); %ԭʼά��
samples = zeros(rowNum, rolNum, N);

%׼����������
 for k=1:N
     imageTemp = imread(imageNameList{k});
     imageTemp = im2double(imageTemp);
     if length(size(imageTemp))==3
        imageTemp = rgb2gray(imageTemp); %�ҶȻ�
        imageTemp = histeq(imageTemp); %ֱ��ͼ���⻯
     end
    imageTemp2 = imresize(imageTemp, newSize);
%     imageTemp3  = imageTemp2(:)';
    samples(:,:,k) = imageTemp2;
 end
end