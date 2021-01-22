%clear all; % close all

R0=3; RL=0.54;
r=1e-4:1e-2:1-1e-4;

% find the standard size of epidemics
rinf=fzero(@(x)(log(1-x)+R0*x),[1e-5 1-1e-5]); 
sinf=1-rinf; 

% point of herd immunity
rstar=1-1/R0; sstar=1/R0;

% lockdown dynamics
thresh=10/100;
r0=0; y0=0; dr=1e-3;
i=1; rl(i)=r0; yl(i)=y0;
while r0<rstar
    [r1,y1] = intersect_SIRthreshold(r0,y0,R0,thresh,dr);
    r0=r1; y0=y1; 
    i=i+1; rl(i)=r0; yl(i)=y0;
    [r1,y1] = intersect_SIRboundary(r0,y0,RL,dr);
    r0=r1; y0=y1; 
    i=i+1; rl(i)=r0; yl(i)=y0;
end
sl=exp(yl);

%figure(1); hold on;
plot(rl, exp(yl),'c','LineWidth',1); hold on; 

istar=find(r>=rstar,1);
%plot(r(1:istar),1-r(1:istar),'r','LineWidth',2); % s+r=1 unstable boundary 
%plot(r(istar:end),1-r(istar:end),'b','LineWidth',2); % s+r=1 stable boundary 

%ir=find(r>1-thresh,1)-1;
%plot(r(1:ir),1-thresh-r(1:ir),'r','LineWidth',1); % s+r=1-thresh boundary 

%plot(rstar,sstar,'ok')
%plot(rl(end),sl(end),'k*','LineWidth',2)

%xlim([0 0.85]); ylim([0.19 1]);
%xlabel('r'); ylabel('s'); set(get(gca,'ylabel'),'rotation',0)
%set(gca, 'YScale', 'log')
