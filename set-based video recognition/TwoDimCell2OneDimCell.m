function output = TwoDimCell2OneDimCell(input,nEachClass,param)
%UNTITLED3 此处显示有关此函数的摘要
%   此处显示详细说明

nClass = param.nClass;
nAllSam = sum(nEachClass);

output = {};
for i1 = 1:nClass
    nClass_i1 = nEachClass(i1);
    output = [output, input(i1,1:nClass_i1) ];
end

end

