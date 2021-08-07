function [ data,label,nEachClass ] = myPreprocess_set_to_matrix( inputdata,inputlabel,param )
%
%  inputdata -  ����cell��ʽ�����ݣ�ÿ��Ԫ����һ�����󣬱�ʾһ��miage set��
%  inputlabel - ÿ��set�ı�ǩ��
%  data - �����cell���ݣ�����ÿһ��Ϊһ���˵�����ͼƬ��ÿ��Ԫ��Ϊһ��ͼƬ��
%
%                 Row - ͼ�������������������ص�����
%                 Column - ͼ�������������������ص�����
%
%  label - ������ݵı�ǩ��

Row = param.Height;
Col = param.Width;

nImageSet = length(inputdata);
nClass = param.nClass;

data = cell(nClass,10000); %Ԥ����cell���ݣ���Ϊÿ��set�ڲ�ͼ��������ͬ������Ԥ��Ϊ10000����ΪĿǰû�г���10000֡��image set
nEachClass = zeros(1,nClass); %�����洢ÿ���к��е�����������

for i1 = 1:nClass
    Class_set_i1 = inputdata(inputlabel==i1); %ȡ����i1������image sets���õ�һ���µ���cell
    Class_i1_images = cell2mat(Class_set_i1);  %��cellתΪmatrix��ÿ�б�ʾһ������ͼ��
    nClass_i1_images = size(Class_i1_images,2);
    nEachClass(i1) = nClass_i1_images;
    for i2 = 1:nClass_i1_images %��ÿ��ͼƬ����תΪͼ�񣬲����浽data��
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

