function [ data ] = myPreprocess_testset_to_matrix( inputdata,param )
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

nSample = size(inputdata,2);
data = cell(1,nSample);
for i2 = 1:nSample %��ÿ��ͼƬ����תΪͼ�񣬲����浽data��
    Class_i1_images_i2 = inputdata(:,i2);
    aa = Class_i1_images_i2;
    %MinValue = min(aa);
    %MaxValue = max(aa);
    %bb = (aa-MinValue)/(MaxValue-MinValue);
    
    bb1 = reshape(aa,[Row,Col]);
    data{i2} = bb1;
end


end

