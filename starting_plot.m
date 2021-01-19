clear all;
R0=3;
r=1e-4:1e-2:1-1e-4;

% find the standard size of epidemics
rinf=fzero(@(x)(log(1-x)+R0*x),[1/R0 1-1e-2]); 
sinf=1-rinf; 

% point of herd immunity
rstar=1-1/R0; sstar=1/R0;


figure(1); hold on; 
plot(r,log(1-r),'b'); % s+r=1 boundary 
%plot(r,-R0*r,'r'); % evolution of si(e)r dynamics (i.e. both sir or seir) 
plot([0 rinf],[0 -R0*rinf],'r'); % evolution of si(e)r dynamics (i.e. both sir or seir) 

% show the distance of herd immunity from the si(e)r dynamics
plot([rstar rstar],[log(sstar) -R0*rstar],'y')
plot([rstar -log(sstar)/R0],[log(sstar) log(sstar)],'y')

plot(rstar,log(sstar),'ok')
plot(rinf,log(sinf),'ok')

hold off
