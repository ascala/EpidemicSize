R0=2; R=3; 
s0=1/R; r0=1-s0;

i0=1e-2;
dr=i0/(R/R0 -1); dlns=-R0*dr;


rr=r0:1e-3:r0+1.1*R*i0; ss=1-rr;
%plot(rr,log(ss),'k')
semilogy(rr,ss,'k')
hold on

plot(r0,s0,'*', [rr(1),rr(end)],[s0-i0,exp( log(s0-i0)-R0*(rr(end)-rr(1)) ) ]); 
plot(r0,s0-i0,'o', [rr(1),rr(end)],[s0,exp( log(s0)-R*(rr(end)-rr(1)) ) ])
%plot(r0,log(s0),'*', [rr(1),rr(end)],[log(s0-i0),log(s0-i0)-R0*(rr(end)-rr(1))]); 
%plot(r0,log(s0-i0),'o', [rr(1),rr(end)],[log(s0),log(s0)-R*(rr(end)-rr(1))])
