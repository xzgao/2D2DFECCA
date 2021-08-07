function [ X,Y ] = CreateVariableM( data,nEachClass,options )
% data: 输入数据为cell形式，cell的每个元素为一个矩阵。data的每一行为一个人的样本
%   Detailed explanation goes here
nCla = options.nClass;
MaxSamples = max(nEachClass);

if strcmp('split',options.method)
    [nRow,nCol] = size(data{1,1}); %每个图像的高和宽
    
    X = cell(nCla,MaxSamples);
    Y = cell(nCla,MaxSamples);
    for i1=1:nCla
        nCla_Sam = nEachClass(i1); %第i1类样本数量
        for j1 = 1:nCla_Sam
            Matrix = data{i1,j1};
            X{i1,j1} = Matrix(:,1:floor(nCol/2));
            Y{i1,j1} = Matrix(:,floor(nCol/2)+1:end);
        end
    end
else if strcmp('wavelet',options.method)
        X = ImageResizeCell( data,options ); 
        Y1 = WaveMultiLevel_gai(data,options);
        Y = Y1;
    else if strcmp('LBP',options.method)
            %X = ImageResizeCell( data,options ); 
            X = data(:,1:MaxSamples);
            Y1 = cellLBP(data,nEachClass,options);
            Y = Y1;
        end
    end
end

