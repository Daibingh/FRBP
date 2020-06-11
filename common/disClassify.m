function [testLabel, rate] = disClassify(x_train, x_label, x_test, disFun, testTrueLabel)
%[testLabel, rate] = disClassify(x_train, x_label, x_test, disFun, testTrueLabel)
n = size(x_train,1);
m = size(x_test,1);
dis = zeros(m,n);
for i=1:m %��������
    for j=1:n
        %dis(i,j) = sqrt(sum((x_test(i,:)-x_train(j,:)).^2));
        dis(i,j) = disFun(x_test(i,:),x_train(j,:));
    end
end
K=1; %KNN����ڵ�kֵ
[~, sortDisIndex] = sort(dis, 2, 'ascend');
testLabel = cell(m,1);
for i=1:m
    KnnClassType_i = (x_label(sortDisIndex(i,:)))';
    testLabel{i} = findMost(KnnClassType_i(1:K)); % ͳ�Ƴ�ǰN����������ĸ���������������������һ��
end
rate = -1;
if nargin == 5
    total = length(testTrueLabel);
    count = 0;
    for i=1:total
        if strcmp(testLabel{i}, testTrueLabel{i})
            count = count+1;
        end
    end
    rate = count/total;
    fprintf('�����׼ȷ����%f\n',rate);
%     figure;
%     h=bar([rate,1-rate]);
%     set(h,'barwidth',.2);
%     set(gca,'xticklabel',{'true rate','false rate'});
end

end