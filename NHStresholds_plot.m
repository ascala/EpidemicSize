clear all;
R0=3;
r=1e-4:1e-2:1-1e-4;
s=1-r;

% find the standard size of epidemics
rinf=fzero(@(x)(log(1-x)+R0*x),[1/R0 1-1e-2]); 
sinf=1-rinf; 

% point of herd immunity
rstar=1-1/R0; sstar=1/R0;


figure(1); hold on; 
%plot(r,log(1-r),'b'); % s+r=1 boundary 
%%plot(r,-R0*r,'r'); % evolution of si(e)r dynamics (i.e. both sir or seir) 
%plot([0 rinf],[0 -R0*rinf],'r'); % evolution of si(e)r dynamics (i.e. both sir or seir) 

[R,S]=meshgrid(min(r):2e-2:max(r),min(s):2e-2:max(s));
ef=1e-2; f=@(r,s)(log((1-ef)*max(1-r-s,0)+ef));
%ef=1e-2; f=@(r,s)((1-ef)*max(1-r-s,0)+ef);
I=f(R,S); Y=log(S);

%surf(R,Y,I, 'EdgeColor', 'none')
%view(0,90)
%colorbar
cMap=jet(256); %set the colomap using the "jet" scale
F2=figure(1);
[c,h]=contourf(R,Y,I,50);
set(h, 'edgecolor','none');


plot([0 rinf],[0 -R0*rinf],'r','LineWidth',2); % evolution of si(e)r dynamics (i.e. both sir or seir) 
%plot(r,-R0*r,'r'); % evolution of si(e)r dynamics (i.e. both sir or seir) 

plot(r,log(1-r),'k','LineWidth',3); % s+r=1 boundary 

thresh=10/100;
ir=find(r>1-thresh,1)-1;
plot(r(1:ir),log(1-thresh-r(1:ir)),'m','LineWidth',2); % s+r=1-thresh boundary 

xlim([0 1]);
ylim([-3.5 0]);
