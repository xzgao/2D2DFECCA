function output = TwoDimCell2OneDimCell(input,nEachClass,param)
%UNTITLED3 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

nClass = param.nClass;
nAllSam = sum(nEachClass);

output = {};
for i1 = 1:nClass
    nClass_i1 = nEachClass(i1);
    output = [output, input(i1,1:nClass_i1) ];
end

end

