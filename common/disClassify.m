function [testLabel, rate] = disClassify(x_train, x_label, x_test, disFun, testTrueLabel)
%[testLabel, rate] = disClassify(x_train, x_label, x_test, disFun, testTrueLabel)
n = size(x_train,1);
m = size(x_test,1);
dis = zeros(m,n);
for i=1:m %求距离矩阵
    for j=1:n
        %dis(i,j) = sqrt(sum((x_test(i,:)-x_train(j,:)).^2));
        dis(i,j) = disFun(x_test(i,:),x_train(j,:));
    end
end
K=1; %KNN最近邻的k值
[~, sortDisIndex] = sort(dis, 2, 'ascend');
testLabel = cell(m,1);
for i=1:m
    KnnClassType_i = (x_label(sortDisIndex(i,:)))';
    testLabel{i} = findMost(KnnClassType_i(1:K)); % 统计出前N个距离最近的个体所属类别出现最多的是哪一类
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
    fprintf('分类的准确度是%f\n',rate);
%     figure;
%     h=bar([rate,1-rate]);
%     set(h,'barwidth',.2);
%     set(gca,'xticklabel',{'true rate','false rate'});
end

end