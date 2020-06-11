function [T, y, x_mean] = my_lda(x, c, ni, lm_num)
% [T, y, x_mean] = my_lda(x, c, ni, lm_num)

[n, d] = size(x);
x_mean = mean(x);
xi_mean=zeros(c,d);
k=1;
for i=1:c
    xi_mean(i,:)=mean(x(k:k+ni(i)-1,:));
    k=k+ni(i);
end
ni_mt = repmat(ni',d,1);
x_mean_mt = repmat(x_mean,c,1);
sb=ni_mt.*(xi_mean-x_mean_mt)'*(xi_mean-x_mean_mt);
sw=zeros(d,d,c);
k=1;
for i=1:c
    xi_mean_mt = repmat(xi_mean(i,:),ni(i),1);
    sw(:,:,i)=(x(k:k+ni(i)-1,:)-xi_mean_mt)'*(x(k:k+ni(i)-1,:)-xi_mean_mt);
    k=k+ni(i);
end
sw = sum(sw,3);
A=sw\sb;
[T,D] = eig(A);
[D2, index] = sort(diag(D), 1, 'descend');
T = T(:, index);
T=T(:,1:lm_num);
% x_zeroMean = x - repmat(x_mean, n, 1);
% y=x_zeroMean*T;
y=x*T;
end