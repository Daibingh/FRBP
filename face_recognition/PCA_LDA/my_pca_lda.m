function [T, y2, x_mean] = my_pca_lda(x, c, ni, lm_num1, lm_num2)
% [T, y2, x_mean] = my_pca_lda(x, c, ni, lm_num1, lm_num2)

[T1, y1, x_mean] = my_pca(x, lm_num1);
[T2, y2] = my_lda(y1, c, ni, lm_num2);
T = T1*T2;
end