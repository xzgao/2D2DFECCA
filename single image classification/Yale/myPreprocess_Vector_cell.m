function [ data,label ] = myPreprocess_Vector_cell( input,name )
%  把三维表示的数据处理为cell数据output.
%  input -  输入的三维数据，例如 ORL_40_10_56_46.mat，载入后变为2576x10x40的三维数据。
%  output - 输出的cell数据，其中每一行为一个人的所有图片，每个元素为一张图片。
%  options - Struct value in Matlab. The fields in options
%                         that can be set:
%
%                 Row - 图像矩阵的行数，即行像素的数量
%                 Column - 图像矩阵的列数，即列像素的数量
%
%  label - 输出数据的标签。

if strcmp('ORL',name)
    Row = 56;
    Col = 46;
    ReRow = 28;
    ReCol = 23;
else if strcmp('Yale',name)
        Row = 100;
        Col = 80;
        ReRow = 25;
        ReCol = 20;
    else if strcmp('FingerDB',name)
            Row = 300;
            Col = 300;
            ReRow = 75;
            ReCol = 75;
        else if strcmp('ar',name)
                Row = 50;
                Col = 40;
                ReRow = 25;
                ReCol = 20;
            else if strcmp('ExtYaleB',name)
                    Row = 96;
                    Col = 84;
                    ReRow = 24;
                    ReCol = 21;
                end
            end
        end
    end
end



[nFeature,nSample,nClass] = size(input); %  nFeature: 特征的维数。 nSample: 每类的样本数。 nClass：类数

data = cell(nClass,nSample);
for i1=1:nClass
    for j1=1:nSample
        aa = input(:,j1,i1);
        
        %%%%%----%%%%%
        %归一化
        MinValue = min(aa);
        MaxValue = max(aa);
        bb = (aa-MinValue)/(MaxValue-MinValue);
        %%%%%----%%%%%
        
        bb1 = reshape(bb,[Row,Col]);
        data{i1,j1} = bb1;
        
        %aa1 = reshape(aa,[Row,Col]);
        %aa2 = imresize(aa1,[ReRow,ReCol]);
        %data{i1,j1} = reshape(aa2,ReRow*ReCol,[])';
        
        %data{i1,j1} = input(:,j1,i1)';
        %data{i1,j1} = imresize(data{i1,j1},[28*23]);
    end
end


label = zeros(nClass,nSample);
for i2 = 1:nClass
    label( i2,: ) = i2*ones(1,nSample);
end

end

