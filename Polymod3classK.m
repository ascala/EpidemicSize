%  POLYMOD matrix aggregated for three age classes: 
%  Y oung (00-19), M iddle (20-69) and E lderly (70+). 

d=3; % number of classes;  1=Y, 2=M, 3=E

%polymod rescaledmatrix
K=[ 2.35 0.44 0.67
    0.47 0.59 0.50
    0.50 0.55 0.80];

%K=[2 1 1
%    1 1 1
%    1 1 1];
    
% ECDC mortality
muECDC(1)= 0.10e-2; % <20	
muECDC(2)= 0.10e-2; % 20-29
muECDC(3)= 0.14e-2; % 30-39
muECDC(4)= 0.26e-2; % 40-49
muECDC(5)= 0.57e-2; % 50-59
muECDC(6)= 2.73e-2; % 60-69
muECDC(7)=10.52e-2; % 70-79
muECDC(8)=20.59e-2; % 80+

% age classes IT
Nit(1) = 2645566 + 2769974 + 2932459 + 2968742; % <20
Nit(2) = 3041263 + 3281737; % 20-29
Nit(3) = 3531873 + 3877837; % 30-39
Nit(4) = 4387315 + 5060898; % 40-49
Nit(5) = 5068741 + 4869741; % 50-59
Nit(6) = 4102571 + 3554615; % 60-69
Nit(7) = 3360175 + 2562688; % 70-79
Nit(8) = 2149368 + 1319626 + 657111 + 212968 + 35096; % 80+

% rescaled mortality
mu=ones(3,1);
mu(1)=muECDC(1);                           %  Y oung (00-19)
mu(2)=muECDC(2:6)*Nit(2:6)'/sum(Nit(2:6)); %  M iddle (20-69) 
mu(3)=muECDC(7:8)*Nit(7:8)'/sum(Nit(7:8)); %  E lderly (70+)

% rescaled classes
N(1)=Nit(1);       %  Y oung (00-19)
N(2)=sum(Nit(2:6)); %  M iddle (20-69) 
N(3)=sum(Nit(7:8)); %  E lderly (70+)
n=N/sum(N); %fraction of population per age class


Rnot=3.0; % basic reproduction number
R=Rnot*K/norm(K); % next generation matrix


% calculate the lattice of extreme points
u=ones(d,1);
% basic solution R*s0=1
s0=pinv(R)*u; 
% s_i is the solution for s(i)=0
R1=R; R1(:,[1])=0; R1([1],:)=0; s1=pinv(R1)*u;
R2=R; R2(:,[2])=0; R2([2],:)=0; s2=pinv(R2)*u;
R3=R; R3(:,[3])=0; R3([3],:)=0; s3=pinv(R3)*u;
% s_ij is the solution for s(i)=s(j)=0
R12=R; R12(:,[1 2])=0; R12([1 2],:)=0; s12=pinv(R12)*u;
R23=R; R23(:,[2 3])=0; R23([2 3],:)=0; s23=pinv(R23)*u;
R13=R; R13(:,[1 3])=0; R13([1 3],:)=0; s13=pinv(R13)*u;
% figure(1); 
% 
% A=[s12 s1 s2]; fill3(A(1,:),A(2,:),A(3,:),'g'); hold on
% A=[s23 s2 s3]; fill3(A(1,:),A(2,:),A(3,:),'g'); hold on
% A=[s13 s1 s3]; fill3(A(1,:),A(2,:),A(3,:),'g'); hold on
% 
% A=[s s1 s2]; fill3(A(1,:),A(2,:),A(3,:),'r'); hold on
% A=[s s1 s3]; fill3(A(1,:),A(2,:),A(3,:),'r'); hold on
% A=[s s2 s3]; fill3(A(1,:),A(2,:),A(3,:),'r'); hold on


eff=0.75; vv=0.7:0.01:1.0;

k=0;
for v=vv
    [smin,rmin,FVAL,EXITFLAG] = MinMortality(d,mu,n,R,eff,v);
    k=k+1; 
    n1(k)=rmin(1); 
    n2(k)=rmin(2); 
    n3(k)=rmin(3);
    m(k)=(n.*smin')*mu*100;
end

figure(2);
subplot(2,1,1)
plot(vv,n3,'r',vv,n2,'b',vv,n1,'g')
subplot(2,1,2)
plot(vv,m,'m')