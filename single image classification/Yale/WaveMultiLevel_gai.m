function [WavedSamples]=WaveMultiLevel_gai(Samples,options)
%修改后，输入Samples是一个cell形式数据，其中每个元素是一个矩阵，表示一张图片。

% 参数：
%Samples：一行一个样本
%Height：源图像高
%Widht：源图像宽
%WaveName：小波的名字，具体见matlab中wfilters函数
%TranTime：对原始图像执行小波的次数，每执行一次小波，宽高各减为原来的一半

%返回值：
%WavedSamples：小波变换后的样本（cell形式的数据，每个元素为一个样本，每行为每类的样本）
%global Par;
WaveName = options.WaveName;
TranTime = options.TranTime;

[ClassNum,TrainNum] = size(Samples);
WavedSamples = cell(ClassNum,TrainNum);
for i=1:ClassNum
    for j=1:TrainNum
        DX = Samples{i,j};
        [c,s] = wavedec2(DX,TranTime,WaveName);
        LowLen = s(1,1)*s(1,2);
        WavedSamples{i,j} = reshape( c(1:LowLen),s(1,1),s(1,2) );
    end
end