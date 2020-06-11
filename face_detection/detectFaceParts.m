% detectFaceParts: detect faces with parts
%
% [bbox,bbX,faces,bbfaces] = detectFaceParts(detector,X,thick)
%
%Output parameters:
% bbox: bbox(:, 1: 4) is bounding box for face
%       bbox(:, 5: 8) is bounding box for left eye
%       bbox(:, 9:12) is bounding box for right eye
%       bbox(:,13:16) is bounding box for mouth
%       bbox(:,17:20) is bounding box for nose
%       please see the documentation of the computer vision toolbox for details of the bounding box.
% bbX: image with found faces which are shown as boxes
% faces: found faces stored as cell array
% bbfaces: found faces with boxes stored as cell array
%
%
%Input parameters:
% detector: the detection object built by buildDetector
% X: image data which should be uint8
% thick(optional): thickness of bounding box (default:1)
%
%
%Example:
% detector = buildDetector();
% img = imread('img.jpg');
% [bbbox bbimg] = detectFaceParts(detector,img);
%
%
%Version: 20140113

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Face Parts Detection:                                    %
%                                                          %
% Copyright (C) 2012 - 2014                                % 
%                    Masayuki Tanaka. All rights reserved. %
%                    mtanaka@ctrl.titech.ac.jp             %
%                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [bbox,bbX,faces,bbfaces] = detectFaceParts(detector,X,thick)

if( nargin < 3 )
 thick = 1;
end

%%%%%%%%%%%%%%%%%%%%%%% detect face %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detect faces
bbox = step(detector.detector{5}, X);

bbsize = size(bbox);
partsNum = zeros(size(bbox,1),1);

%%%%%%%%%%%%%%%%%%%%%%% detect parts %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
nameDetector = {'LeftEye'; 'RightEye'; 'Mouth'; 'Nose'; };
mins = [[12 18]; [12 18]; [15 25]; [15 18]; ];

stdsize = detector.stdsize;

for k=1:4
 if( k == 1 )
  region = [1,int32(stdsize*2/3); 1, int32(stdsize*2/3)];
 elseif( k == 2 )
  region = [int32(stdsize/3),stdsize; 1, int32(stdsize*2/3)];
 elseif( k == 3 )
  region = [1,stdsize; int32(stdsize/3), stdsize];
 elseif( k == 4 )
  region = [int32(stdsize/5),int32(stdsize*4/5); int32(stdsize/3),stdsize];
 else
  region = [1,stdsize;1,stdsize];
 end

 bb = zeros(bbsize);
 for i=1:size(bbox,1)
  XX = X(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
  XX = imresize(XX,[stdsize, stdsize]);
  XX = XX(region(2,1):region(2,2),region(1,1):region(1,2),:);
  
  b = step(detector.detector{k},XX);
  
  if( size(b,1) > 0 )
   partsNum(i) = partsNum(i) + 1;
   
   if( k == 1 )
    b = sortrows(b,1);
   elseif( k == 2 )
    b = flipud(sortrows(b,1));
   elseif( k == 3 )
    b = flipud(sortrows(b,2));
   elseif( k == 4 )
    b = flipud(sortrows(b,3));
   end
   
   ratio = double(bbox(i,3)) / double(stdsize);
   b(1,1) = int32( ( b(1,1)-1 + region(1,1)-1 ) * ratio + 0.5 ) + bbox(i,1);
   b(1,2) = int32( ( b(1,2)-1 + region(2,1)-1 ) * ratio + 0.5 ) + bbox(i,2);
   b(1,3) = int32( b(1,3) * ratio + 0.5 );
   b(1,4) = int32( b(1,4) * ratio + 0.5 );
   
   bb(i,:) = b(1,:);
  end
 end
 bbox = [bbox,bb];
 
 p = ( sum(bb') == 0 );
 bb(p,:) = [];
end


%%%%%%%%%%%%%%%%%%%%%%% draw faces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
bbox = [bbox,partsNum];
bbox(partsNum<=2,:)=[];

if( thick >= 0 )
 t = (thick-1)/2;
 t0 = -int32(ceil(t));
 t1 = int32(floor(t));
else
 t0 = 0;
 t1 = 0;
end

bbX = X;
boxColor = [[0,255,0]; [255,0,255]; [255,0,255]; [0,255,255]; [255,255,0]; ];
for k=5:-1:1
 shapeInserter = vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',boxColor(k,:)); 
 for i=t0:t1
  bb = int32(bbox(:,(k-1)*4+1:k*4));
  bb(:,1:2) = bb(:,1:2)-i;
  bb(:,3:4) = bb(:,3:4)+i*2;
  bbX = step(shapeInserter, bbX, bb);
 end
end

%%%%%%%%%%%%%%%%%%%%%%% faces %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if( nargout > 2 )
 faces = cell(size(bbox,1),1);
 bbfaces = cell(size(bbox,1),1);
 for i=1:size(bbox,1)
  faces{i,1} = X(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
  bbfaces{i,1} = bbX(bbox(i,2):bbox(i,2)+bbox(i,4)-1,bbox(i,1):bbox(i,1)+bbox(i,3)-1,:);
 end
end

