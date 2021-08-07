
function [Acc1,Acc2] = main( Traindata,Testdata,options )


TrainNum = options.TrainNum;
ClassNum = options.nClass;
TestNum = options.nSample - TrainNum;
N = options.nClass*TrainNum;
M = options.nClass*(options.nSample-TrainNum);

[ X,Y ] = CreateVariableM( Traindata,options );
[ TestX,TestY ] = CreateVariableM( Testdata,options );

X = reshape(X',1,N);
Y = reshape(Y',1,N);
TestX = reshape(TestX',1,M);
TestY = reshape(TestY',1,M);
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
%%% end 中心化

d1 = options.d1;
d2 = options.d2;
RxI = 0.1*ones(nx,d2); %初始化
RyI = 0.1*ones(ny,d2);

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

TrainDataX = zeros(ClassNum*TrainNum,d1*d2);
for ii1 = 1:ClassNum*TrainNum
    TrainDataX(ii1,:) = reshape( Lx'*X{ii1}*Rx,1,d1*d2 );
end
TrainDataY = zeros(ClassNum*TrainNum,d1*d2);
for ii1 = 1:ClassNum*TrainNum
    TrainDataY(ii1,:) = reshape( Ly'*Y{ii1}*Ry,1,d1*d2 );
end
TestDataX = zeros(ClassNum*TestNum,d1*d2);
for ii2 = 1:ClassNum*TestNum
    TestDataX(ii2,:) = reshape( Lx'*TestX{ii2}*Rx,1,d1*d2 );
end
TestDataY = zeros(ClassNum*TestNum,d1*d2);
for ii2 = 1:ClassNum*TestNum
    TestDataY(ii2,:) = reshape( Ly'*TestY{ii2}*Ry,1,d1*d2 );
end
%%%
%%% feature fusion strategy  FFS1
TrainF1 = [TrainDataX,TrainDataY];
TestF1 = [TestDataX,TestDataY];
%%%

%%% FFS2
TrainF2 = TrainDataX + TrainDataY;
TestF2 = TestDataX + TestDataY;
%%%

TrainF1 = real(TrainF1);
TestF1 = real(TestF1);
TrainF2 = real(TrainF2);
TestF2 = real(TestF2);

TrainLabel=[];
for jj1=1:ClassNum
    A=jj1*ones(TrainNum,1);
    TrainLabel=[TrainLabel;A];
end
TestLabel=[];
for jj2=1:ClassNum
    A=jj2*ones(TestNum,1);
    TestLabel=[TestLabel;A];
end

Pre1 = knnclassify(TestF1,TrainF1,TrainLabel,1,'cosine','random');
Acc1 = sum(Pre1==TestLabel)/numel(TestLabel);
fprintf('The classification accuracy of FFS1 is:%f\n',100*Acc1);

Pre2 = knnclassify(TestF2,TrainF2,TrainLabel,1,'cosine','random');
Acc2 = sum(Pre2==TestLabel)/numel(TestLabel);
fprintf('The classification accuracy of FFS2 is:%f\n',100*Acc2);


end


