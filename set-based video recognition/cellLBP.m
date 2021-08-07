function [WavedSamples]=cellLBP(Samples,nEachClass,options)
%�޸ĺ�����Samples��һ��cell��ʽ���ݣ�����ÿ��Ԫ����һ�����󣬱�ʾһ��ͼƬ��

% ������
%Samples��һ��һ������
%Height��Դͼ���
%Widht��Դͼ���
%WaveName��С�������֣������matlab��wfilters����
%TranTime����ԭʼͼ��ִ��С���Ĵ�����ÿִ��һ��С������߸���Ϊԭ����һ��

%����ֵ��

ClassNum = options.nClass;
MaxSamples = max(nEachClass);
WavedSamples = cell(ClassNum,MaxSamples);
for i=1:ClassNum
    nCla_Sam = nEachClass(i); %��i1����������
    for j=1:nCla_Sam
        I = Samples{i,j};      
        SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
        I2=LBP(I,SP,0,'i'); %LBP code image using sampling points in SP
       
        WavedSamples{i,j} = double(I2);
        %WavedSamples{i,j} = imresize(I2,[28,23]);
    end
end