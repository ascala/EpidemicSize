clear all; % close all;
R0=3;
r=1e-4:1e-2:1-1e-4;

% find the standard size of epidemics
r0=0; s0=1; y0=log(s0);
[rinf,yinf]=fzero(@(x)(log(1-x)+R0*x),[1/R0 1-1e-2]); 
sinf=1-rinf; 

% point of herd immunity
rstar=1-1/R0; sstar=1/R0;

figure(2); hold on; 
%orangered=[255 69 0]/255;
%darkorange=[255 140 0]/255;
%orange=[255 165 0]/255;

istar=find(r>=rstar,1);
plot(r(1:istar),1-r(1:istar),'r','LineWidth',2); % s+r=1 unstable boundary 
plot(r(istar:end),1-r(istar:end),'b','LineWidth',2); % s+r=1 stable boundary 

plot([r0 rinf],[s0 sinf],'g'); % evolution of si(e)r dynamics (i.e. both sir or seir) 

%plot(rstar,sstar,'ok')
%plot(rinf,sinf,'ok')

xlim([0 1]); ylim([0.05 1]);
xlabel('r'); ylabel('s'); set(get(gca,'ylabel'),'rotation',0)
set(gca, 'YScale', 'log')
