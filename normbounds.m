d=3;
R0=3.0; tau0=1;
mu0=1/tau0; b0=mu0*R0;

dB=rand(d)/d; dB=(dB+dB')/2; dB=dB-diag(diag(dB));
%B=diag(b0*ones(d,1)-0.5/d)+dB
B=b0*ones(1,d)-sum(dB);
B=diag(B)+dB;

Sig=mu0*(ones(d,1)+(rand(d,1)-0.5)/d); 
Sig=diag(Sig);
iSig=pinv(Sig);

figure(1); 
sz=0:1e-3:1;
s0=rand(d,1); s0=s0/max(s0);
k=0; n=[]; z=[]; n0=[]; n1=[]; 
for a=sz
    s=a*s0;
    T=B.*s';
    K=T*iSig;
    k=k+1;
    n(k)=norm(K);
    krows=K'*ones(d,1);
    z(k)=sum(krows<1);
    n0(k)=min(krows);
    n1(k)=max(krows);
end
plot(sz,n,'b',sz,n0,'g',sz,n1,'g',sz,z/d,'.r');
hold on
j=find(n>=1,1);  plot(sz(j),n(j),'ob');
j=find(z<d,1);  plot(sz(j-1),z(j-1)/d,'xr');
hold off
