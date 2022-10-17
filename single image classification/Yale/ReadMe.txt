

clear;
clc;
close all;



% You should modify parameters in "Start.m"
%   param.TrainNum: your training number 
%   param.nSamples: the sample number of each class
%   param.nClass:   the class number
%  

% Here is an example on Yale database when the training number is 3
% let p1 = 1; p2 = 0.9; p3 = 0.9; d = 19;
[meanaccFFS1,meanaccFFS2,stdaccFFS1,stdaccFFS2] = Start(1,0.9,0.9,19);
