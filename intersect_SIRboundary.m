function [r1,y1] = intersect_SIRboundary(r0,y0,R,dr)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    rx=r0; if(r0==0) r0=dr/10; end
    while log(1-rx) > (y0-R*(rx-r0))
        rx=rx+dr;
    end
    r1=fzero(@(x)( log(1-x) - (y0-R*(x-r0)) ),[rx-dr rx]);
    y1=y0-R*(r1-r0);
end
