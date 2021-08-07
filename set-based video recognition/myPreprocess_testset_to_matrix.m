function [ data ] = myPreprocess_testset_to_matrix( inputdata,param )
%
%  inputdata -  输入cell格式的数据，每个元素是一个矩阵，表示一个miage set。
%  inputlabel - 每个set的标签。
%  data - 输出的cell数据，其中每一行为一个人的所有图片，每个元素为一张图片。
%
%                 Row - 图像矩阵的行数，即行像素的数量
%                 Column - 图像矩阵的列数，即列像素的数量
%
%  label - 输出数据的标签。

Row = param.Height;
Col = param.Width;

nSample = size(inputdata,2);
data = cell(1,nSample);
for i2 = 1:nSample %把每个图片向量转为图像，并保存到data中
    Class_i1_images_i2 = inputdata(:,i2);
    aa = Class_i1_images_i2;
    %MinValue = min(aa);
    %MaxValue = max(aa);
    %bb = (aa-MinValue)/(MaxValue-MinValue);
    
    bb1 = reshape(aa,[Row,Col]);
    data{i2} = bb1;
end


end

