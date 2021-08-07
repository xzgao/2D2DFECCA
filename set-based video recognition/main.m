

function [Acc1,Acc2] = main( param )

[TrainData,TestData,TrainLabel,TestLabel] = DataProcess(param);
[ Traindata,TrainLabel,nEachClass ] = myPreprocess_set_to_matrix( TrainData,TrainLabel,param );


options = param;
ClassNum = options.nClass;
%[ClassNum,PicNum]=size(Temp);
%TestNum=PicNum-TrainNum;

[ X,Y ] = CreateVariableM( Traindata,nEachClass,options );

X = TwoDimCell2OneDimCell(X,nEachClass,options);  %将m*n维的cell拉伸为1*（mn）维
Y = TwoDimCell2OneDimCell(Y,nEachClass,options);
N = length(X);

%%%%

[mx,nx] = size(X{1,1});
[my,ny] = size(Y{1,1});

%%% centering
Sum_x = zeros(mx,nx);
for i1 = 1:N
    Sum_x = Sum_x+X{i1};
end
M_x = Sum_x/N; 

X_hat = cell(1,N);
for k1 = 1:N
    X_hat{k1} = X{k1}-M_x;
end

Sum_y = zeros(my,ny);
for j1 = 1:N
    Sum_y = Sum_y+Y{j1};
end
M_y = Sum_y/N; 

Y_hat = cell(1,N);
for t1 = 1:N
    Y_hat{t1} = Y{t1}-M_y;
end
%%% end 

d = options.d;
RxI = 0.1*ones(nx,d); %初始化
RyI = 0.1*ones(ny,d);
%RxI=rand(nx,d);
%RyI=rand(ny,d);
LoopNum = 20;
myeps = 1e-3;

for loop = 1:LoopNum
    
    [ Lx,Ly ] = kcca2dr( X_hat,Y_hat,RxI,RyI,N,my,options );
    [ Rx,Ry ] = kcca2dl( X_hat,Y_hat,Lx,Ly,N,ny,options );
    if (( norm(Rx-RxI)<myeps ) && ( norm(Ry-RyI)<myeps ))
        break;
    end
    RxI = Rx;
    RyI = Ry;
    
end
fprintf('Number of iteration:%d\n',loop); %总迭代次数。

TrainDataX = zeros(N,d*d);
for ii1 = 1:N
    TrainDataX(ii1,:) = reshape( Lx'*X{ii1}*Rx,1,d*d );
end
TrainDataY = zeros(N,d*d);
for ii1 = 1:N
    TrainDataY(ii1,:) = reshape( Ly'*Y{ii1}*Ry,1,d*d );
end
%%% feature fusion strategy:  FFS1
TrainF1 = [TrainDataX,TrainDataY];
%%%

%%% FFS2
TrainF2 = TrainDataX + TrainDataY;
%%%
TrainF1 = real(TrainF1);
TrainF2 = real(TrainF2);

nTestSet = length(TestData);
SetPre1 = zeros(1,nTestSet);
SetPre2 = zeros(1,nTestSet);
for ii3 = 1:nTestSet
    TestSet_ii3 = TestData{ii3};
    [ Traindata_ii3] = myPreprocess_testset_to_matrix( TestSet_ii3,param );
    nTest_Samples_ii3 = length(Traindata_ii3);
    [ TestX,TestY ] = CreateVariableM_test( Traindata_ii3,options );
    
    TestDataX_ii3 = zeros(nTest_Samples_ii3,d*d);
    for ii2 = 1:nTest_Samples_ii3
        TestDataX_ii3(ii2,:) = reshape( Lx'*TestX{ii2}*Rx,1,d*d );
    end
    TestDataY_ii3 = zeros(nTest_Samples_ii3,d*d);
    for ii2 = 1:nTest_Samples_ii3
        TestDataY_ii3(ii2,:) = reshape( Ly'*TestY{ii2}*Ry,1,d*d );
    end
    %%% feature fusion strategy:  FFS1
    TestF1 = [TestDataX_ii3,TestDataY_ii3];
    %%%
    %%% FFS2
    TestF2 = TestDataX_ii3 + TestDataY_ii3;
    %%%
    TestF1 = real(TestF1);
    TestF2 = real(TestF2);
    Pre1 = knnclassify(TestF1,TrainF1,TrainLabel,1,'cosine','random');
    Pre2 = knnclassify(TestF2,TrainF2,TrainLabel,1,'cosine','random');
    
    [a1] = tabulate(Pre1(:));
    [value1,location1] = max(a1(:,2));
    SetPre1(ii3) = a1(location1,1);

     [a2] = tabulate(Pre2(:));
    [value2,location2] = max(a2(:,2));
    SetPre2(ii3) = a2(location2,1);
    
end


Acc1 = sum(SetPre1==TestLabel)/numel(TestLabel);
fprintf('Classification accuracy of FFS1 is:%f\n',100*Acc1);

Acc2 = sum(SetPre2==TestLabel)/numel(TestLabel);
fprintf('Classification accuracy of FFS is:%f\n',100*Acc2);


end


