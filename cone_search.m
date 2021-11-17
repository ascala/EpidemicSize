clear all; 

R =[
    1.9660    0.1022    0.6160
    1.4168    0.4936    1.6564
    0.3806    0.1162    0.6693];


R=[ 2.0  1  0.5
     1  1.5 0.7  
    0.5 0.7  1 ]; R=3*R/norm(R);


ph=0:pi/60:pi/2;
th=0:pi/30:pi/2;
k=0;
for p=ph
    for t=th
        x=cos(p); y=sin(p); z=sin(t);
        s=[x; y; z]; 
        k=k+1;
        ss(k,:)=s/max(R*s);
        SS(k,:)=s/min(R*s);
    end
end