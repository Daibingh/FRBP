function [test_label, rate] = lda_test(filename, test_name, disFun, test_label_true)
% [test_label, rate] = lda_test(filename, test_name, disFun, test_label_true)

if isempty(filename)
    filename = 'lda_data';
end
load(filename, 'train_label', 'oldSize', 'newSize', 'x_mean_train', 'T', 'y_train');
[x_test, ~]=arrDataMat(test_name, newSize);
%对测试样本进行投影
testNum = size(test_name, 1); 
% x_test_zeroMean = x_test-repmat(x_mean_train, testNum,1);
% y_test = x_test_zeroMean*T;
y_test = x_test*T;
%分类并统计准确率
if nargin ==4
[test_label, rate] = disClassify(y_train, train_label, y_test, disFun, test_label_true);
else 
[test_label, rate] = disClassify(y_train, train_label, y_test, disFun);
end

end