function [test_label, rate]= pca_test(filename,test_name,disFun, test_label_true)
% [test_label, rate]= pca_test(filename,test_name,disFun, test_label_true)

%功能：训练样本，得到特征空间的投影矩阵，并求测试样本的类别
%输入：
% testImageNameList：测试图像名称列表（元胞数组）
% trueClassType：测试真实类别
%输出：
%testClassType：分类结果
if isempty(filename)
    filename = 'pca_data';
end
load (filename,'train_label','newSize', 'oldSize', 'x_mean_train','T','y_train');

%调用子函数，将测试样本转化为数据阵
[x_test]=arrDataMat(test_name, newSize);
testNum = size(x_test,1);
x_zeroMean = x_test-repmat(x_mean_train,testNum,1);
y_test = x_zeroMean*T;%求测试样本的特征脸

if nargin == 4
    [test_label, rate] = disClassify(y_train, train_label, y_test, disFun, test_label_true);
else
    [test_label, rate] = disClassify(y_train, train_label, y_test, disFun);
end

end