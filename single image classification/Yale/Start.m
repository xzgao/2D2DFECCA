
function [meanaccFFS1,meanaccFFS2,stdaccFFS1,stdaccFFS2] = Start(p1,p2,p3,d)
%close all;
%clear global;
%clear;
%clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Fix parameters
options = [];
options.TrainNum = 3;
options.nSample = 11;
options.nClass = 15;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%------------------------------------------------------------------------
%可调参数区
options.method = 'wavelet'; % construct the second view feature
options.WaveName = 'db1';

%options.method = 'split'; 
%options.method = 'LBP';

options.TranTime = 2;
options.d1 = d; % Reduced dimension
options.d2 = d;
options.epsilon = 1e-3;

options.FraOrdx_r = p1;
options.FraOrdy_r = p2;
options.FraOrd_r = p3;
options.FraOrdx_l = p1;
options.FraOrdy_l = p2;
options.FraOrd_l = p3;
%------------------------------------------------------------------------


load('database/Yale_15_11_100_80.mat')
name = 'Yale';

input = DAT(:,:,:); 
[ data,label ] = myPreprocess_Vector_cell( input,name ); % data: 15*11cell, each row is one class
%---------------------------------
L1 = label(:,1:options.TrainNum);
Trainlabel = reshape(L1',[options.TrainNum*options.nClass,1]);
L2 = label(:,options.TrainNum+1:end);
Testlabel = reshape(L2',[(options.nSample-options.TrainNum)*options.nClass,1]);
%---------------------------------

fold = 10;
allaccFFS1 = zeros(1,fold);
allaccFFS2 = zeros(1,fold);
alltime = zeros(1,fold);

for i1 = 1:fold 
    
    %%%%%%%%%%%%%%%%% Train Test Construct %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    rand('state',i1); % fix the random state
    rand_num = randperm(options.nSample); % random order
    Traindata = data(:,rand_num(1:options.TrainNum));
    Testdata = data(:,rand_num(options.TrainNum+1:end)); % row cell
    %%%%%%%%%%%%%%%%% Train Test Construct %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    tic;
    [AccFFS1,AccFFS2] = main( Traindata,Testdata,options );
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
