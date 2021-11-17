function [smin,rmin,v1,v2,FVAL,EXITFLAG] = MinMortality2vax(d,mu,n,R,eff1,eff2,v1,v2)
%MinMortality looks for a stable solutio of S(E)IR that minimezes mortality
%   d       number of classes
%   mu      mortality (per class)
%   n       fraction of population (per class)
%   R       next generation matrix
%   eff1    vaccine efficacy 1 shot
%   eff2    vaccine efficacy 2 shots
%   v1      fraction of single shots
%   v2      fraction of double shots

%Auxiliary:
%   v       fraction of vaccinated
v=v1+2*v2;

% output: a vector x of dimension 2*d where
% x(1:d)=s
% x(d+1:2*d)=r

%NOTA: ho dovuto sostituire il vincolo R s = 1 con R s <=1
%se no non trovava mai soluzione feasible (OVVIO LEGGI IL PAPER)

% LINPROG finds a solution x of the form [s r]


%equality constraints:
% s+r=1 
Aeq=[eye(d),eye(d)];
Beq=[ones(d,1)];

%Auxiliary:
%   eff       effectively immune
eff=eff1*v1+eff2*v2;

%inequality constraints:
% (eff1*v1+eff2*v2)*R*s<=1
A=[eff*R,zeros(d,d)]; % R*s,0*r
B=[ones(d,1)+1e-6];
% sum r n < eff1*v1+eff2*v2
A=[A; [zeros(1,d) n] ]; 
B=[B;eff];

%objective function =  mu^T s
f=[mu; zeros(d,1); 0; 0];

%lower and upper bound
lb=zeros(2*d+2,1);
ub=ones(2*d+2,1);

% linear programming
[x,FVAL,EXITFLAG] = linprog(f,A,B,Aeq,Beq,lb,ub);
smin=x(1:d);
rmin=x(d+1:2*d);
v1=x(2*d+1);
v2=x(2*d+2);

end

