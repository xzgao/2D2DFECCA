function [ data,label,nEachClass ] = myPreprocess_set_to_matrix( inputdata,inputlabel,param )
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

nImageSet = length(inputdata);
nClass = param.nClass;

data = cell(nClass,10000); %预定义cell数据，因为每个set内部图像数量不同，这里预设为10000，因为目前没有超过10000帧的image set
nEachClass = zeros(1,nClass); %用来存储每类中含有的总样本数量

for i1 = 1:nClass
    Class_set_i1 = inputdata(inputlabel==i1); %取出第i1类所有image sets，得到一个新的行cell
    Class_i1_images = cell2mat(Class_set_i1);  %行cell转为matrix，每列表示一个样本图像；
    nClass_i1_images = size(Class_i1_images,2);
    nEachClass(i1) = nClass_i1_images;
    for i2 = 1:nClass_i1_images %把每个图片向量转为图像，并保存到data中
        Class_i1_images_i2 = Class_i1_images(:,i2);
        aa = Class_i1_images_i2;
        %MinValue = min(aa);
        %MaxValue = max(aa);
        %bb = (aa-MinValue)/(MaxValue-MinValue);
        
        bb1 = reshape(aa,[Row,Col]);
        data{i1,i2} = bb1;
    end
end




label = [];
for i3 = 1:nClass
    nClass_i1_images = nEachClass(i3);
    label = [label; i3*ones(nClass_i1_images,1)];
end

end

