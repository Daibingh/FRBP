clc
clear all
load pca_data;
[m,n] = size(T);
t = T + repmat(x_mean_train',1, n);
tt = reshape(t, [newSize(1) newSize(2), n]);
fea = zeros(oldSize(1),oldSize(2), n);
for i=1:n
    fea(:,:,i) = imresize(tt(:,:,i),oldSize);
end
l = 10;
figure;
img = reshape(fea(:,:,1:l), oldSize(1), l*oldSize(2));
imshow(img)
figure;
img = reshape(fea(:,:,end-l+1:end), oldSize(1), l*oldSize(2));
imshow(img)