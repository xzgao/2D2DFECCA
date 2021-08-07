function [ Rx,Ry ] = kcca2dl( X_hat,Y_hat,Lx,Ly,N,ny,Par )
FraOrdx = Par.FraOrdx_l;
FraOrdy = Par.FraOrdy_l;
FraOrd = Par.FraOrd_l;

epsilon=Par.epsilon;
d=Par.d;
lx=Lx;
ly=Ly;
lxlx=lx*lx';
lyly=ly*ly';
lxly=lx*ly';


sum1=0;
for i1=1:N
    sum1=sum1+X_hat{i1}'*lxlx*X_hat{i1};
end
sigma_l_xx=sum1/N;

sum2=0;
for j1=1:N
    sum2=sum2+Y_hat{j1}'*lyly*Y_hat{j1};
end
sigma_l_yy=sum2/N;

sum12=0;
for k1=1:N
    sum12=sum12+X_hat{k1}'*lxly*Y_hat{k1};
end
sigma_l_xy=sum12/N;

%%%%%%%%%%%%%%%%%%%%%%%%%-Fractional-order-%%%%%%%%%%%%%%%%%%%%%%
[Px,Dx]=eig(sigma_l_xx); 
for i=1:size(Dx,1)
    if Dx(i,i)~=0
        Dx(i,i)=Dx(i,i)^FraOrdx;
    end    
end
sigma_l_xx=Px*Dx*Px';

[Py,Dy]=eig(sigma_l_yy); 
for i=1:size(Dy,1)
    if Dy(i,i)~=0
        Dy(i,i)=Dy(i,i)^FraOrdy;
    end
end
sigma_l_yy=Py*Dy*Py';

[U,D,V]=svd(sigma_l_xy); 
for i=1:min(size(sigma_l_xy))
    if D(i,i)~=0
        D(i,i)=D(i,i)^FraOrd;
    end
end
sigma_l_xy=U*D*V';
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

ax=size(sigma_l_xx,1);
if( det(sigma_l_xx)<1e-12)
    sigma_l_xx = sigma_l_xx + trace(sigma_l_xx)*epsilon*eye(ax);
end
ay=size(sigma_l_yy,1);
if( det(sigma_l_yy)<1e-12)
    sigma_l_yy = sigma_l_yy + trace(sigma_l_yy)*epsilon*eye(ay);
end


sigma_r_yx=sigma_l_xy';

z=sigma_l_xx\sigma_l_xy*(sigma_l_yy\sigma_r_yx);
z=0.5*(z+z');
[Rx,r]=eig(z);
[newr,IX] = sort(diag(r),'descend'); 
r = diag(newr); 
Rx = Rx(:,IX);
r = sqrt(real(r)); % as the original r we get is lamda^2 
Rx=Rx(:,1:d);
r=r(1:d,1:d); 
Ry=(sigma_l_yy\sigma_r_yx)*Rx;


Ry=Ry./repmat(diag(r)',ny,1);

end

