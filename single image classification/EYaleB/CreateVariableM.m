function [ X,Y ] = CreateVariableM( data,options )
% data: 输入数据为cell形式，cell的每个元素为一个矩阵。data的每一行为一个人的样本
%   Detailed explanation goes here

if strcmp('split',options.method)
    [nCla,nSamp] = size(data);
    [nRow,nCol] = size(data{1,1}); 
    
    X = cell(nCla,nSamp);
    Y = cell(nCla,nSamp);
    for i1=1:nCla
        for j1 = 1:nSamp
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
            X = ImageResizeCell( data,options ); 
            Y1 = cellLBP(data);
            Y = Y1;
        end
    end
end

