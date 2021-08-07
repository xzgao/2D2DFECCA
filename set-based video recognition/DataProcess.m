
function [TrainData,TestData,TrainLabel,TestLabel] = DataProcess(param)

% TrainData: 1*n �� cell��ʽ��ÿ��Ԫ��Ϊһ��ͼ�񼯾���
% TestData�� same to TrainData��

frame = param.frame;

load('database\Honda-UCSD-Wang.mat');


TrainNum = param.TrainNum;
nClass = param.nClass;
nImgSet = param.nImgSet;
nTrain = TrainNum*nClass;
nTest = nImgSet - nTrain;


ImgData_He_Train = cell(1,nTrain); 
ImgData_He_Test = cell(1,nTest);
MatrixTrain_Label = zeros();
MatrixTest_Label = zeros();
for i1 = 1:nClass
    nClass_i = nEachClass(i1); % The number of image sets belonging to class i.
    Class_i = ImgData_He(1:nClass_i,i1); %Image sets belonging to class i.
    
    %---
    Class_i1 = Class_i'; % ת��
    rand('state',param.fix_j); %�̶�����������̵�״̬
    rand_num = randperm(nClass_i);

    %[Train,Test]=rand_cell_column_mat(Class_i1,TrainNum); %�����Class_i1��ѡ��1����Ϊѵ������������ʣ�������������Ϊ��������
    Train_i = Class_i1(rand_num(1:TrainNum));
    Test_i = Class_i1(rand_num(TrainNum+1:end)); % ��cell
    %---
    
    nTrain_i = size(Train_i,2);
    nTest_i = size(Test_i,2);
    
    nTrain_Nozero = length( find(MatrixTrain_Label~=0) ); %��0Ԫ�صĸ���
    nTest_Nozero = length( find(MatrixTest_Label~=0) ); %��0Ԫ�صĸ���
    ImgData_He_Train(1,nTrain_Nozero+1:nTrain_Nozero+nTrain_i ) = Train_i;
    ImgData_He_Test(1,nTest_Nozero+1:nTest_Nozero+nTest_i) = Test_i;
    
    MatrixTrain_Label(1:nTrain_i,i1) = i1*ones(nTrain_i,1);
    MatrixTest_Label(1:nTest_i,i1) = i1*ones(nTest_i,1);
end
%----% ����ѵ�������Լ���ǩ
TrainLabel = reshape(MatrixTrain_Label,1,size(MatrixTrain_Label,1)*size(MatrixTrain_Label,2));
TrainLabel( TrainLabel == 0 ) = [];  %ɾ�������0Ԫ��

TestLabel = reshape(MatrixTest_Label,1,size(MatrixTest_Label,1)*size(MatrixTest_Label,2));
TestLabel( TestLabel == 0 ) = [];  %ɾ�������0Ԫ��


for i2 = 1:nTrain
    DataSet_i = ImgData_He_Train{i2};
    if (size(DataSet_i,2)>frame)
        ImgData_He_Train{i2} = DataSet_i(:,1:frame);%/256;
    else
        ImgData_He_Train{i2} = DataSet_i;%/256;
    end
end

for i3 = 1:nTest
    DataSet_i = ImgData_He_Test{i3};
    if (size(DataSet_i,2)>frame)
        ImgData_He_Test{i3} = DataSet_i(:,1:frame);%/256;
    else
        ImgData_He_Test{i3} = DataSet_i;%/256;
    end
end

TrainData = ImgData_He_Train;
TestData = ImgData_He_Test;

end


