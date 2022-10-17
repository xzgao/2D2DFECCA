

clear;
clc;
close all;


% You can first load your data at "DataProcess.m", then runing the following code.
% Then modify parameters in "Start.m"
%   param.Height:   the height of your imput image
%   param.Width:    the width  of ...
%   param.TrainNum: your training number of image sets(or video)
%   param.nImgSet:  the total number of image sets(or video)
%   param.nClass:   the class number
%   param.frame:    using the first xxx frames in each video, for example...
%                   50, 100. If you wang to use all frames, just set a very big number, e.g., 10000.

% Here is an example on Honda database when using the first 50 frames.
% let p1 = 0.3; p2 = 0.8; p3 = 0.8; d = 20;
[meanaccFFS1,meanaccFFS2,stdaccFFS1,stdaccFFS2] = Start(0.3,0.8,0.8,20);
