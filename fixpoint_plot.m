clear all;
R0=3; RL=R0*(1-0.82);
r=1e-4:1e-2:1-1e-4;

% find the standard size of epidemics
rinf=fzero(@(x)(log(1-x)+R0*x),[1e-2 1-1e-2]); 
sinf=1-rinf; 

% point of herd immunity
rstar=1-1/R0; sstar=1/R0;



figure(1); hold on; 
plot(r,log(1-r),'b'); % s+r=1 boundary 
%plot(r,-R0*r,'r'); % evolution of si(e)r dynamics (i.e. both sir or seir) 
plot([0 rinf],[0 -R0*rinf],'r'); % evolution of si(e)r dynamics (i.e. both sir or seir) 

plot(rstar,log(sstar),'ok')

% FIXPOINT

dL=0.25;

y10=log(1-1*dL);r10 = -y10/R0;
%plot([0 r10],[log(1) y10],'g')
r1inf=fzero(@(x)( log(1-x) - (y10-RL*(x-r10)) ),[r10+1e-2 1-1e-2]);
y1inf=log(1-r1inf);
%plot([r10 r1inf],[y10 y1inf],'g')

y20=log(1-2*dL); r20 = r1inf-(y20-y1inf)/R0;
%plot([r1inf r20],[y1inf y20],'g')
r2inf=fzero(@(x)( log(1-x) - (y20-RL*(x-r20)) ),[r20+1e-2 1-1e-2]);
y2inf=log(1-r2inf);
%plot([r20 r2inf],[y20 y2inf],'g')

y30=log(1-3*dL); r30 = r2inf-(y30-y2inf)/R0;
%plot([r2inf r30],[y2inf y30],'g')
r3inf=fzero(@(x)( log(1-x) - (y30-RL*(x-r30)) ),[r30+1e-2 1-1e-2]);
y3inf=log(1-r3inf);
%plot([r30 r3inf],[y30 y3inf],'g')

plot([0 r10 r1inf r20 r2inf r30 r3inf],[log(1) y10 y1inf y20 y2inf y30 y3inf],'g')

%y40=log(1-4*dL); r40 = r3inf-(y40-y3inf)/R0;
%plot([r3inf r40],[y3inf y40],'g')
%r4inf=fzero(@(x)( log(1-x) - (y40-RL*(x-r40)) ),[r40+1e-2 1-1e-2]);
%y4inf=log(1-r4inf);
%plot([r40 r4inf],[y40 y4inf],'g')
