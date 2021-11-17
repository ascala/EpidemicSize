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

%figure(1); hold on;
sz=0:1e-3:1;
hit1=[]; hit2=[]; j=0;
for i=1:10000
    s0=rand(d,1); s0=s0/max(s0);
    k=0; n=[]; z=[]; 
    for a=sz
        s=a*s0;
        T=B.*s';
        K=T*iSig;
        k=k+1;
        n(k)=norm(K);
        z(k)=sum(K'*ones(d,1)<1);
    end
    %plot(sz,n,'b',sz,z/3,'.r')
    j=j+1;
    hit1(j)=sz(find(n>1,1));
    hit2(j)=sz(find(z<d,1));
end
plot(hit1,hit2,'ob',hit1,hit1,'k',hit2,hit2,'r')