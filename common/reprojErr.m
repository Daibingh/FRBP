function e = reprojErr(x, mean, t)
% x = reproj(y, mean, t)

y = proj(x, mean, t);
x_z = y*t';
x2 = x_z + repmat(mean, size(y, 1), 1);
e  = sqrt(sum((x2-x).^2, 2));
end