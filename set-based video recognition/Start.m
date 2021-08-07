
function [meanaccFFS1,meanaccFFS2,stdaccFFS1,stdaccFFS2] = Start(p1,p2,p3,d)
%close all;
%clear global;
%clear;
%clc;

warning('off');
param.Height = 20;
param.Width = 20;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fixed parameters
param.TrainNum = 1;
param.nImgSet = 59;
param.nClass = 20;
param.frame = 50;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------------------------------------------------------
%parameters
%param.method = 'wavelet'; 
%param.WaveName = 'db1';
%options.method = 'split';
%param.TranTime = 1;

param.method = 'LBP'; % In our paper, only 'LBP'is used.
param.d = d;  % Reduced dimension
param.epsilon = 1e-3;

%p = 1;
param.FraOrdx_r = p1;  % alpha_r^x
param.FraOrdy_r = p2;  %alpha_r^y
param.FraOrd_r = p3;   %beta_r
param.FraOrdx_l = p1;
param.FraOrdy_l = p2;
param.FraOrd_l = p3;
%------------------------------------------------------------------------



fold = 10;
allaccFFS1 = zeros(1,fold);
allaccFFS2 = zeros(1,fold);
alltime = zeros(1,fold);

for i1 = 1:fold
    param.fix_j = i1;
    tic;
    [AccFFS1,AccFFS2] = main( param );
    t1 = toc;
    allaccFFS1(i1) = AccFFS1;
    allaccFFS2(i1) = AccFFS2;
    alltime(i1) = t1;
end



stdaccFFS1 = std(100*allaccFFS1);
meanaccFFS1 = mean(100*allaccFFS1);
fprintf('10 fold std of FFS1:%f\n',stdaccFFS1); 
fprintf('10 fold mean accuracy of FFS1:%f\n',meanaccFFS1); 

stdaccFFS2 = std(100*allaccFFS2);
meanaccFFS2 = mean(100*allaccFFS2);
fprintf('10 fold std of FFS2:%f\n',stdaccFFS2); 
fprintf('10 fold mean accuracy of FFS2:%f\n',meanaccFFS2); 




end
