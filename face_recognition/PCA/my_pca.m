function [T, y, x_mean] = my_pca(x, lm_num)
% [T, y, x_mean] = my_pca(x, lm_num)

N=size(x,1);
x_mean = mean(x);
x_zeroMean=x-repmat(x_mean,N,1);%计算零均值的人脸样本
cov = x_zeroMean*x_zeroMean';%求协方差矩阵
[v, d] = eig(cov);
lamna = diag(d);
[D, indx] = sort(lamna,1,'descend');%对特征值进行排序
rankV = v(:,indx);%对特征向量排序
T2 = rankV(:,1:lm_num);
D2 = D(1:lm_num);
T3 = simitzj(T2,D2); %特征向量的归一化，正交化
% T3 = T2;
%求a'a的特征值特征向量,还原为原始协方差的特征向量
L = repmat((1./sqrt(D2))',N,1);
T=x_zeroMean'*(T3.*L);%投影矩阵


%求训练样本的特征脸
y = x_zeroMean*T; %求训练样本特征脸
end