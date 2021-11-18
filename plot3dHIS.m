K=[ 2.35 0.44 0.67
    0.47 0.59 0.50
    0.50 0.55 0.80];
Rnot=2; % basic reproduction number
R=Rnot*K/norm(K); % next generation matrix (since gamma=1)

R=[ 2.5 0.7 0.3
    0.7 2.1 0.7
    0.3 0.7 1.8];
R=3*R/norm(R);

%R=1.2*eye(3)+0.3*(ones(3)-eye(3));
R=2.0*eye(3)+1.0*(ones(3)-eye(3));
%R=1.5*eye(3)+0.75*(ones(3)-eye(3)); % norm(R)=3

% the boundary of the set { s : Rs<1 } represent the Herd Immunity Surface HES   
% the function fz(x,y) finds the z such that, for given x,y, Rzx*x+Rzy*y+Rzz*z=1
% i.e., for given x,y, finds the z on the HES. Same reasoning for fx and fy

% points to sample. ranges are obviosly contained in [0,1] 
del=5e-3;
samplex=0:del:min(1,1/R(1,1));
sampley=0:del:min(1,1/R(2,2));
samplez=0:del:min(1,1/R(3,3));


% find the z(x,y) boundary
fz= @(x,y) (1-R(3,1)*x-R(3,2)*y)/R(3,3); % given (x,y), finds z
count=0; x1=[]; y1=[]; z1=[];
for x=samplex
  for y=sampley
    z=fz(x,y);
    s=[x;y;z];
    g=R*s;
    % z must be in [0,1]
    % no component of R*s must be >1
    if z>=0 && sum(g>1)==0
      count=count+1;
      x1(count)=x; y1(count)=y; z1(count)=z; 
    end
  end
end

% find the y(x,z) boundary
fy= @(z,x) (1-R(2,1)*x-R(2,3)*z)/R(2,2); % given (x,z), finds y
count=0; x2=[]; y2=[]; z2=[];
for z=samplez
  for x=samplex
    y=fy(z,x);
    s=[x;y;z];
    g=R*s;
    % y must be in [0,1]
    % no component of R*s must be >1
    if y>=0 && sum(g>1)==0
      count=count+1;
      x2(count)=x; y2(count)=y; z2(count)=z; 
    end
  end
end

% find the x(y,z) boundary
fx= @(y,z) (1-R(1,2)*y-R(1,3)*z)/R(1,1); % given (y,z), finds x
count=0; x3=[]; y3=[]; z3=[];
for y=sampley
  for z=samplez
    x=fx(y,z);
    s=[x;y;z];
    g=R*s;
    % x must be in [0,1]
    % no component of R*s must be >1
    if x>=0 && sum(g>1)==0
      count=count+1;
      x3(count)=x; y3(count)=y; z3(count)=z; 
    end
  end
end

figure(1);
scatter3(x1,y1,z1,[],'.r'); hold on
scatter3(x2,y2,z2,[],'.g'); 
scatter3(x3,y3,z3,[],'.b');   
hold off
axis([0 1 0 1 0 1])

% the vertices of the HES can be calculated analytically
% s0 is the foremost vertex
s0=R\[1;1;1]; 
% sa in the vertex on the a=0 plane
v=R([2 3],[2 3])\[1;1]; sx=[0;v(1);v(2)]; 
v=R([1 3],[1 3])\[1;1]; sy=[v(1);0;v(2)];   
v=R([1 2],[1 2])\[1;1]; sz=[v(1);v(2);0];
% sab is the vertex on the a=0,b=0 axis
syz=[R(1,1)\1;0;0]; szx=[0;R(2,2)\1;0]; sxy=[0;0;R(3,3)\1];     
%%% fill3 is only defined in MATLAB !!!
if not( exist ("OCTAVE_VERSION", "builtin") ) % not running octave
    figure(2)
    A=[s0 sx sxy sy]; fill3(A(1,:),A(2,:),A(3,:),'r'); hold on
    A=[s0 sz szx sx]; fill3(A(1,:),A(2,:),A(3,:),'g'); 
    A=[s0 sy syz sz]; fill3(A(1,:),A(2,:),A(3,:),'b'); 
    hold off
    axis([0 1 0 1 0 1])
end
