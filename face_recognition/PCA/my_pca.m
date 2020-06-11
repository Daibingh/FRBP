function [T, y, x_mean] = my_pca(x, lm_num)
% [T, y, x_mean] = my_pca(x, lm_num)

N=size(x,1);
x_mean = mean(x);
x_zeroMean=x-repmat(x_mean,N,1);%�������ֵ����������
cov = x_zeroMean*x_zeroMean';%��Э�������
[v, d] = eig(cov);
lamna = diag(d);
[D, indx] = sort(lamna,1,'descend');%������ֵ��������
rankV = v(:,indx);%��������������
T2 = rankV(:,1:lm_num);
D2 = D(1:lm_num);
T3 = simitzj(T2,D2); %���������Ĺ�һ����������
% T3 = T2;
%��a'a������ֵ��������,��ԭΪԭʼЭ�������������
L = repmat((1./sqrt(D2))',N,1);
T=x_zeroMean'*(T3.*L);%ͶӰ����


%��ѵ��������������
y = x_zeroMean*T; %��ѵ������������
end