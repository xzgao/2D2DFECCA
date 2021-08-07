function [WavedSamples]=cellLBP_test(Samples,options)
%�޸ĺ�����Samples��һ��cell��ʽ���ݣ�����ÿ��Ԫ����һ�����󣬱�ʾһ��ͼƬ��

% ������
%Samples��һ��һ������
%Height��Դͼ���
%Widht��Դͼ���
%WaveName��С�������֣������matlab��wfilters����
%TranTime����ԭʼͼ��ִ��С���Ĵ�����ÿִ��һ��С������߸���Ϊԭ����һ��

%����ֵ��
nSamples = length(Samples);

WavedSamples = cell(1,nSamples);

for j=1:nSamples
    I = Samples{1,j};
    SP=[-1 -1; -1 0; -1 1; 0 -1; -0 1; 1 -1; 1 0; 1 1];
    I2=LBP(I,SP,0,'i'); %LBP code image using sampling points in SP
    
    WavedSamples{1,j} = double(I2);
    %WavedSamples{i,j} = imresize(I2,[28,23]);
end

end