function [test_label, rate] = mpca_test(filename, test_name, disFun, test_label_true)
% [test_label, rate] = mpca_test(filename, test_name, disFun, test_label_true)

if isempty(filename)
    filename = 'mpca_data';
end
load(filename, 'newSize', 'oldSize', 'train_label', 'T', 'x_mean_train2D', 'ord', 'p', 'y_train');

[x_test2D, ~]=arrDataMat2D(test_name, newSize);
N=2;  %Order of the tensor sample
n = size(test_name, 1);
x_zeroMean_test2D=x_test2D-repmat(x_mean_train2D,[ones(1,N), n]);  %Centering
y_test2D=ttm(tensor(x_zeroMean_test2D), T, 1:N);   %MPCA projection
newDim = size(y_test2D, 1) * size(y_test2D, 2);
y_test=reshape(y_test2D.data, newDim, n)';%Note: Transposed
y_test=y_test(:,ord(1:p));%Select the first "P" sorted features
if nargin == 4
    [test_label, rate] = disClassify(y_train, train_label, y_test, disFun, test_label_true);
else
    [test_label, rate] = disClassify(y_train, train_label, y_test, disFun);
end
end