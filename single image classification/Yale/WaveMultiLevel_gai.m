function [WavedSamples]=WaveMultiLevel_gai(Samples,options)
%�޸ĺ�����Samples��һ��cell��ʽ���ݣ�����ÿ��Ԫ����һ�����󣬱�ʾһ��ͼƬ��

% ������
%Samples��һ��һ������
%Height��Դͼ���
%Widht��Դͼ���
%WaveName��С�������֣������matlab��wfilters����
%TranTime����ԭʼͼ��ִ��С���Ĵ�����ÿִ��һ��С������߸���Ϊԭ����һ��

%����ֵ��
%WavedSamples��С���任���������cell��ʽ�����ݣ�ÿ��Ԫ��Ϊһ��������ÿ��Ϊÿ���������
%global Par;
WaveName = options.WaveName;
TranTime = options.TranTime;

[ClassNum,TrainNum] = size(Samples);
WavedSamples = cell(ClassNum,TrainNum);
for i=1:ClassNum
    for j=1:TrainNum
        DX = Samples{i,j};
        [c,s] = wavedec2(DX,TranTime,WaveName);
        LowLen = s(1,1)*s(1,2);
        WavedSamples{i,j} = reshape( c(1:LowLen),s(1,1),s(1,2) );
    end
end