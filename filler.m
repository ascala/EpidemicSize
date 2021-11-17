clear all

R=[ 2.0  1  0.5
     1  1.5 0.7  
    0.5 0.7  1 ]; 

R=eye(3)+0.1*ones(3);

R=3*R/norm(R);
del=1/30;
range=0:del:1;

k0=0; k1=0; k2=0;
for x=range
    for y=range
        for z=range
            s=[x;y;z];
            i=sum(R*s<1);
            if i==3
%                k0=k0+1; x0(k0)=s(1); y0(k0)=s(2); z0(k0)=s(3);
            end
            if i==2
                k1=k1+1; x1(k1)=s(1); y1(k1)=s(2); z1(k1)=s(3);
            end
            if i==1
                k2=k2+1; x2(k2)=s(1); y2(k2)=s(2); z2(k2)=s(3);
            end
        end
    end
end

