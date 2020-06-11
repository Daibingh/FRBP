function [face_box, faces, img] = my_face_detector(img)
%����Matlab��������㷨 Viola-Jones algorithm + �ֲ�������֤����������㷨
%[face_box, faces, img] = My_face_detector(img)
%���룺
% img: �����ͼ��
% �����
% face_box: ����λ�� n*4 [x,y,w,h]
% faces: ��ȡ��������ͼ��cell����
% img: �ѱ��������ͼ��
if length(size(img)) == 2
    img = repmat(img, 1,1,3);
end
detector = buildDetector();
[bbox, ~, faces, ~] = detectFaceParts(detector, img);

%���boxǶ������
n=size(bbox,1);
bbox = bbox(:,1:4);
bbox = sortrows(bbox,3);
flg = zeros(n,1);
for i=1:n-1
    for j=i+1:n
        x1=bbox(i,1);
        x2=bbox(j,1);
        y1=bbox(i,2);
        y2=bbox(j,2);
        w1=bbox(i,3);
        w2=bbox(j,3);
        h1=bbox(i,4);
        h2=bbox(j,4);
    if h2 > h1 && abs(x1-x2) < w1 && abs(y1 -y2) < h1 
        flg(j,:) = 1;
    end
    end
end
bbox(flg==1,:) = [];
faces(flg==1,:) = [];

face_box = bbox;
% shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[0,255,0]);
img = insertShape(img, 'Rectangle', face_box, 'color', [0, 255, 0], 'linewidth', 4);
% for i=1:size(face_box,1)
%     img = insertObjectAnnotation(img, 'rectangle', face_box(i,:), 'face');
% end
end
