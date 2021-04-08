function [smin,rmin,FVAL,EXITFLAG] = MinMortality(d,mu,n,R,eff,v)
%MinMortality looks for a stable solutio of S(E)IR that minimezes mortality
%   d       number of classes
%   mu      mortality (per class)
%   n       fraction of population (per class)
%   R       next generation matrix
%   eff     vaccine efficiency
%   v       fraction of vaccines

%NOTA: ho dovuto sostituire il vincolo R s = 1 con R s <=1
%se no non trovava mai soluzione feasible

% LINPROG finds a solution x of the form [s r]


%equality constraints:
%s+r=1
Aeq=[eye(d),eye(d)];
Beq=ones(d,1);

%inequality constraints:
% R*s<=eff
A=[R,zeros(d,d)]; 
B=eff*ones(d,1)+1e-6;
% sum r n < vac
A=[A; [zeros(1,d) n] ]; B=[B;v];

%objective function =  mu^T s
f=[mu; zeros(d,1)];

%lower and upper bound
lb=zeros(2*d,1);
ub=ones(2*d,1);

% linear programming
[x,FVAL,EXITFLAG] = linprog(f,A,B,Aeq,Beq,lb,ub);
smin=x(1:d);
rmin=x(d+1:end);

end

