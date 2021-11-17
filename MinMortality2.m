function [vopt,FVAL,EXITFLAG] = MinMortality2(d,mu,n,R,eff,v)
%MinMortality looks for a stable solutio of S(E)IR that minimezes mortality
%   d       number of classes
%   mu      mortality (per class)
%   n       fraction of population (per class)
%   R       next generation matrix
%   eff     vaccine efficiency
%   v       fraction of vaccinated


% VINCOLI: (suppongo comunque che v<1)
%   R*diag(1-vopt)+(1-eff)*R*diag(vopt) < ones(d)  
%   n*vopt=v

%equality constraints:
%n*vopt=v
Aeq=[n];
Beq=v*ones(1,1);

%inequality constraints:
%   R*diag(1-vopt)+(1-eff)*R*diag(vopt) <ones(d)
%   -eff*R*diag(vopt) < ones(d)-R
%    eff*R*diag(vopt) > R-ones(d)
A=[-eff*R]; 
B=-(R-eye(d))*ones(d,1)+1e-6;

%objective function =  mu^T*(1-vopt)
f=[-mu];

%lower and upper bound
lb=zeros(d,1);
ub=ones(d,1);

% linear programming
[vopt,FVAL,EXITFLAG] = linprog(f,A,B,Aeq,Beq,lb,ub);

end

