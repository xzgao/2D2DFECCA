function [ data,label ] = myPreprocess_Vector_cell( input,name )
%  ����ά��ʾ�����ݴ���Ϊcell����output.
%  input -  �������ά���ݣ����� ORL_40_10_56_46.mat��������Ϊ2576x10x40����ά���ݡ�
%  output - �����cell���ݣ�����ÿһ��Ϊһ���˵�����ͼƬ��ÿ��Ԫ��Ϊһ��ͼƬ��
%  options - Struct value in Matlab. The fields in options
%                         that can be set:
%
%                 Row - ͼ�������������������ص�����
%                 Column - ͼ�������������������ص�����
%
%  label - ������ݵı�ǩ��

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



[nFeature,nSample,nClass] = size(input); %  nFeature: ������ά���� nSample: ÿ����������� nClass������

data = cell(nClass,nSample);
for i1=1:nClass
    for j1=1:nSample
        aa = input(:,j1,i1);
        
        %%%%%----%%%%%
        %��һ��
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

