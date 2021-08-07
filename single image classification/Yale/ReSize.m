function [Train,Test] = ReSize(Train_B,Test_B)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[ClassNum,TrainNum] = size(Train_B);
[~,TestNum] = size(Test_B);
Train = cell(ClassNum,TrainNum);
Test = cell(ClassNum,TestNum);

for i1=1:ClassNum
    for j1=1:TrainNum
        Matrix1 = Train_B{i1,j1};
        Train{i1,j1} = imresize(Matrix1,[28,23]);
    end
end

for i2=1:ClassNum
    for j2=1:TestNum
        Matrix2 = Test_B{i2,j2};
        Test{i2,j2} = imresize(Matrix2,[28,23]);
    end
end

end

