% buildDetector: build face parts detector object
% 
% detector = buildDetector( thresholdFace, thresholdParts, stdsize )
%
%Output parameter:
% detector: built detector object
%
%
%Input parameters:
% thresholdFace (optional): MergeThreshold for face detector (Default: 1)
% thresholdParts (optional): MergeThreshold for face parts detector (Default: 1)
% stdsize (optional): size of normalized face (Default: 176)
%
%
%Example:
% detector = buildDetector();
% img = imread('img.jpg');
% [bbbox bbimg] = detectFaceParts(detector,img);
%
%
%Version: 20120529

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Face Parts Detection:                                    %
%                                                          %
% Copyright (C) 2012 Masayuki Tanaka. All rights reserved. %
%                    mtanaka@ctrl.titech.ac.jp             %
%                                                          %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function detector = buildDetector( thresholdFace, thresholdParts, stdsize )

if( nargin < 1 )
 thresholdFace = 1;
end

if( nargin < 2 )
 thresholdParts = 1;
end

if( nargin < 3 )
 stdsize = 176;
end

nameDetector = {'LeftEye'; 'RightEye'; 'Mouth'; 'Nose'; };
mins = [[12 18]; [12 18]; [15 25]; [15 18]; ];

detector.stdsize = stdsize;
detector.detector = cell(5,1);
for k=1:4
 minSize = int32([stdsize/5 stdsize/5]);
 minSize = [max(minSize(1),mins(k,1)), max(minSize(2),mins(k,2))];
 detector.detector{k} = vision.CascadeObjectDetector(char(nameDetector(k)), 'MergeThreshold', thresholdParts, 'MinSize', minSize);
end

detector.detector{5} = vision.CascadeObjectDetector('FrontalFaceCART', 'MergeThreshold', thresholdFace);
