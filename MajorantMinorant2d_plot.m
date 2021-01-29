%clear all; close all
BETA= [2.3 1.6; 1.1 2.1];
GAMMA = diag([1.0 1.3]);
R0=BETA*inv(GAMMA);
one=[1;1];
sstar = R0 \ one
smax = 1./diag(R0);

figure(1); hold on;
axis([0 1 0 1]);


% "golden" point
plot(sstar(1),sstar(2),'k*');

% majorant
plot([0 1],[smax(2) smax(2)],'r');
plot([smax(1) smax(1)],[0 1],'r');
plot(smax(1),smax(2),'rs');

% minorant
xmin=[0 smax(1)];
ymin=[smax(2) 0];
plot(xmin,ymin,'b');
plot(0,smax(2),'ob',smax(1),0,'ob');
