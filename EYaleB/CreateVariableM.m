function [ X,Y ] = CreateVariableM( data,options )
% data: ��������Ϊcell��ʽ��cell��ÿ��Ԫ��Ϊһ������data��ÿһ��Ϊһ���˵�����
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

