%clear all; close all
BETA= [2.3 1.6; 1.1 2.1];
GAMMA = diag([1.0 1.3]);
R0=BETA*inv(GAMMA);
one=[1;1];
sstar = R0 \ one
Smax = 1./R0;

figure(2); hold on;
axis([0 1 0 1]);

% 1
x1=[0 Smax(1,1)]; y1=[Smax(1,2) 0];
plot(x1,y1,'b');
plot(0,Smax(1,2),'ob',Smax(1,1),0,'ob');

% 2
x2=[0 Smax(2,1)]; y2=[Smax(2,2) 0];
plot(x2,y2,'g');
plot(0,Smax(2,2),'og',Smax(2,1),0,'og');

% "golden" point
plot(sstar(1),sstar(2),'k*');
