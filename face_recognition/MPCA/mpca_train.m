function mpca_train(trainInfo, newSize, p, filename)
% mpca_train(trainInfo, newSize, p, filename)

%读取训练样本、测试样本图片，构成数据矩阵
[x_train2D, oldSize] = arrDataMat2D(trainInfo.name_list,newSize);

N=ndims(x_train2D)-1;  %Order of the tensor sample
Is=size(x_train2D);    %32x32x320
numSpl=Is(3);   %There are 320 face samples
testQ=97;   %Keep 97% variation in each mode
maxK=1; %One iteration only

[T, ord, x_mean_train2D, ~] = MPCA(x_train2D, trainInfo.label_list, testQ, maxK);

x_zeroMean_train2D=x_train2D-repmat(x_mean_train2D,[ones(1,N), numSpl]);  %Centering
y_train2D=ttm(tensor(x_zeroMean_train2D),T,1:N);   %MPCA projection
%Vectorization of the tensorial feature
newDim=size(y_train2D,1)*size(y_train2D,2);
if p > newDim || p <= 0
    p = newDim;
    disp(['mpca_train: newDim = ', num2str(newDim), ', set p to ', num2str(newDim)]);
end

y_train=reshape(y_train2D.data,newDim,numSpl)';%Note: Transposed
y_train = y_train(:,ord(1:p));
train_label = trainInfo.label_list;
if nargin ==3
    filename = 'mpca_data';
end
save(filename, 'newSize', 'oldSize', 'train_label', 'T', 'x_mean_train2D', 'ord', 'p', 'y_train');
end