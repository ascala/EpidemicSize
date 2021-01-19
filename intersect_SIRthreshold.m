function [r1,y1] = intersect_SIRthreshold(r0,y0,R,thresh,dr)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    rx=r0; 
    while log(1-rx-thresh)<(y0-R*(rx-r0)) 
        rx=rx+dr;
    end
    if rx<0.8
        r1=fzero(@(x)( log(1-x-thresh) - (y0-R*(x-r0)) ),[rx-dr rx]);
        y1=y0-R*(r1-r0);
    else
        rx=r0+dr; dr=1e-3;
        while log(1-rx) > (y0-R*(rx-r0))
            rx=rx+dr;
        end
        r1=fzero(@(x)( log(1-x) - (y0-R*(x-r0)) ),[rx-dr rx]);
%        [r1,y1]=intersect_SIRboundary(r0,y0,R,dr)
    end
    y1=y0-R*(r1-r0);
end

