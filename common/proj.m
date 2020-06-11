function y = proj(x, mean, t)
% y = proj(x, mean, t)

x_z = x - repmat(mean, size(x,1), 1);
y = x_z*t;
end