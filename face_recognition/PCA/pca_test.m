function [test_label, rate]= pca_test(filename,test_name,disFun, test_label_true)
% [test_label, rate]= pca_test(filename,test_name,disFun, test_label_true)

%���ܣ�ѵ���������õ������ռ��ͶӰ���󣬲���������������
%���룺
% testImageNameList������ͼ�������б�Ԫ�����飩
% trueClassType��������ʵ���
%�����
%testClassType��������
if isempty(filename)
    filename = 'pca_data';
end
load (filename,'train_label','newSize', 'oldSize', 'x_mean_train','T','y_train');

%�����Ӻ���������������ת��Ϊ������
[x_test]=arrDataMat(test_name, newSize);
testNum = size(x_test,1);
x_zeroMean = x_test-repmat(x_mean_train,testNum,1);
y_test = x_zeroMean*T;%�����������������

if nargin == 4
    [test_label, rate] = disClassify(y_train, train_label, y_test, disFun, test_label_true);
else
    [test_label, rate] = disClassify(y_train, train_label, y_test, disFun);
end

end