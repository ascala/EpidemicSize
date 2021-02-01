clear all;
n=3;

B=2*eye(n)+ones(n);
g=ones(n,1); G=diag(g);
R=B*inv(G);
u=ones(n,1);

s=pinv(R)*u;

R1=R; R1(:,[1])=0; R1([1],:)=0; s1=pinv(R1)*u;
R2=R; R2(:,[2])=0; R2([2],:)=0; s2=pinv(R2)*u
R3=R; R3(:,[3])=0; R3([3],:)=0; s3=pinv(R3)*u

R12=R; R12(:,[1 2])=0; R12([1 2],:)=0; s12=pinv(R12)*u;
R23=R; R23(:,[2 3])=0; R23([2 3],:)=0; s23=pinv(R23)*u;
R13=R; R13(:,[1 3])=0; R13([1 3],:)=0; s13=pinv(R13)*u;

figure(1); 

XYZ=[s12 s23 s13 s12]; plot3(XYZ(1,:),XYZ(2,:),XYZ(3,:),'b')
hold on
xyz=[s1 s2 s3 s1]; plot3(xyz(1,:),xyz(2,:),xyz(3,:),'c')

a=[s1 s12]; plot3(a(1,:),a(2,:),a(3,:),'g')
a=[s1 s13]; plot3(a(1,:),a(2,:),a(3,:),'g')

a=[s2 s12]; plot3(a(1,:),a(2,:),a(3,:),'g')
a=[s2 s23]; plot3(a(1,:),a(2,:),a(3,:),'g')

a=[s3 s13]; plot3(a(1,:),a(2,:),a(3,:),'g')
a=[s3 s23]; plot3(a(1,:),a(2,:),a(3,:),'g')

a=[s s1]; plot3(a(1,:),a(2,:),a(3,:),'r')
a=[s s2]; plot3(a(1,:),a(2,:),a(3,:),'r')
a=[s s3]; plot3(a(1,:),a(2,:),a(3,:),'r')

figure(2); 

A=[s12 s1 s2]; fill3(A(1,:),A(2,:),A(3,:),'g'); hold on
A=[s23 s2 s3]; fill3(A(1,:),A(2,:),A(3,:),'g'); hold on
A=[s13 s1 s3]; fill3(A(1,:),A(2,:),A(3,:),'g'); hold on

A=[s s1 s2]; fill3(A(1,:),A(2,:),A(3,:),'r'); hold on
A=[s s1 s3]; fill3(A(1,:),A(2,:),A(3,:),'r'); hold on
A=[s s2 s3]; fill3(A(1,:),A(2,:),A(3,:),'r'); hold on
