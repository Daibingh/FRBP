function showEigenface(t, imgSize, ind)
% showEigenface(t, imgSize, ind)

t1 = uint8(mapminmax(t', 0, 255))';
tt1 = reshape(t1, [imgSize(1), imgSize(2), size(t, 2)]);
img = reshape(tt1(:,:,ind),imgSize(1), length(ind)*imgSize(2));
imshow(img)
end