function [ Lx,Ly ] = kcca2dr( X_hat,Y_hat,Rx,Ry,N,my,Par )
FraOrdx = Par.FraOrdx_r;
FraOrdy = Par.FraOrdy_r;
FraOrd = Par.FraOrd_r;

epsilon = Par.epsilon;
d=Par.d;

rx=Rx;
ry=Ry;
rxrx=rx*rx';
ryry=ry*ry';
rxry=rx*ry';


sum1=0;
for i1=1:N
    sum1=sum1+X_hat{i1}*rxrx*X_hat{i1}';
end
sigma_r_xx=sum1/N;

sum2=0;
for j1=1:N
    sum2=sum2+Y_hat{j1}*ryry*Y_hat{j1}';
end
sigma_r_yy=sum2/N;

sum12=0;
for k1=1:N
    sum12=sum12+X_hat{k1}*rxry*Y_hat{k1}';
end
sigma_r_xy=sum12/N;

%%%%%%%%%%%%%%%%%%%%%%%%%-Fractional-order-%%%%%%%%%%%%%%%%%%%%%%
[Px,Dx]=eig(sigma_r_xx); 
for i=1:size(Dx,1)
    if Dx(i,i)~=0
        Dx(i,i)=Dx(i,i)^FraOrdx;
    end    
end
sigma_r_xx=Px*Dx*Px';

[Py,Dy]=eig(sigma_r_yy); 
for i=1:size(Dy,1)
    if Dy(i,i)~=0
        Dy(i,i)=Dy(i,i)^FraOrdy;
    end
end
sigma_r_yy=Py*Dy*Py';

[U,D,V]=svd(sigma_r_xy); 
for i=1:min(size(sigma_r_xy))
    if D(i,i)~=0
        D(i,i)=D(i,i)^FraOrd;
    end
end
sigma_r_xy=U*D*V';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ay=size(sigma_r_yy,1);
if( det(sigma_r_yy)<1e-12)
    sigma_r_yy = sigma_r_yy + trace(sigma_r_yy)*epsilon*eye(ay);
end
ax=size(sigma_r_xx,1);
if( det(sigma_r_xx)<1e-12)
    sigma_r_xx = sigma_r_xx + trace(sigma_r_xx)*epsilon*eye(ax);
end

sigma_r_yx=sigma_r_xy';

z=sigma_r_xx\sigma_r_xy*(sigma_r_yy\sigma_r_yx);
z=0.5*(z+z');

[Lx,r]=eig(z);
[newr,IX] = sort(diag(r),'descend');
r = diag(newr); 
Lx = Lx(:,IX);
r = sqrt(real(r)); % as the original r we get is lamda^2  %realÇóÊµ²¿
Lx=Lx(:,1:d);
r=r(1:d,1:d);
Ly=(sigma_r_yy\sigma_r_yx)*Lx;


Ly=Ly./repmat(diag(r)',my,1);
end


