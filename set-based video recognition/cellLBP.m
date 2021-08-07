function [WavedSamples]=cellLBP(Samples,nEachClass,options)
%修改后，输入Samples是一个cell形式数据，其中每个元素是一个矩阵，表示一张图片。

% 参数：
%Samples：一行一个样本
%Height：源图像高
%Widht：源图像宽
%WaveName：小波的名字，具体见matlab中wfilters函数
%TranTime：对原始图像执行小波的次数，每执行一次小波，宽高各减为原来的一半

%返回值：

ClassNum = options.nClass;
MaxSamples = max(nEachClass);
WavedSamples = cell(ClassNum,MaxSamples);
for i=1:ClassNum
    nCla_Sam = nEachClass(i); %第i1类样本数量
    for j=1:nCla_Sam
        I = Samples{i,j};      
        SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
        I2=LBP(I,SP,0,'i'); %LBP code image using sampling points in SP
       
        WavedSamples{i,j} = double(I2);
        %WavedSamples{i,j} = imresize(I2,[28,23]);
    end
end