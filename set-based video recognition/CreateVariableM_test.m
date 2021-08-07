function [ X,Y ] = CreateVariableM_test( data,options )
% data: 输入数据为cell形式，cell的每个元素为一个矩阵。data的每一行为一个人的样本
%   Detailed explanation goes here
nSamples = length(data);

if strcmp('split',options.method)
    [nRow,nCol] = size(data{1,1}); %每个图像的高和宽
    
    X = cell(1,nSamples);
    Y = cell(1,nSamples);
    
    for j1 = 1:nSamples
        Matrix = data{1,j1};
        X{1,j1} = Matrix(:,1:floor(nCol/2));
        Y{1,j1} = Matrix(:,floor(nCol/2)+1:end);
    end
    
else if strcmp('wavelet',options.method)
        X = ImageResizeCell( data,options );
        Y1 = WaveMultiLevel_gai(data,options);
        Y = Y1;
    else if strcmp('LBP',options.method)
            %X = ImageResizeCell( data,options );
            X = data;
            Y1 = cellLBP_test(data,options);
            Y = Y1;
        end
    end
end

