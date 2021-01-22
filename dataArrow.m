function obj = dataArrow(Xdata,Ydata,ax)
%This function will draw an arrow on the plot for the specified data.
%The inputs are 
    oldunits = get(ax, 'Units');
    set(ax, 'Units', 'Normalized');
    axpos = get(ax,'Position');
    set(ax, 'Units', oldunits);
    %get axes drawing area in data units
    axlim = axis(ax);              % Get the axis limits [xlim ylim (zlim)]
    ax_xlim = axlim(1:2);
    ax_ylim = axlim(3:4);
    ax_per_xdata = axpos(3) ./ diff(ax_xlim);
    ax_per_ydata = axpos(4) ./ diff(ax_ylim);
    %these are figure-relative
    Xpixels = (Xdata - ax_xlim(1)) .* ax_per_xdata + axpos(1);
    Ypixels = (Ydata - ax_ylim(1)) .* ax_per_ydata + axpos(2);
    obj = annotation('arrow', Xpixels, Ypixels, 'Units', 'pixels');
end