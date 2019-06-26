function varargout = vplt(float_name,plotornot)
% [mag,theta]=vplt(float_name,plotornot)
% 
% Plots properties of surface and subsurface velocity
%
% INPUT:
% 
% float_name  Name/number of mermaid float 
% plotornot   1 makes plots (default)
%             0 does not
%
% OUTPUT:
%
% mag         The magnitude vector of mermaid velocity
% theta       The angle vector of mermaid velocity in radians
%
% Last modified by fge@princeton.edu on 6/26/19

defval('float_name','P017');
defval('plotornot',0);
[name,t,lat,lon]=mread(float_name);
n=length(t);

% magnitude calculation
ellapsed_time=date2sec(t);
arclen(2:n)=distance(lat(2:n),lon(2:n),lat(1:n-1),lon(1:n-1));
dist=distdim(arclen,'deg','m','earth');
mag=dist./ellapsed_time;

% angle calculation
dellat(2:n)=lat(2:n)-lat(1:n-1);
dellon(2:n)=lon(2:n)-lon(1:n-1);
theta=atan(dellat./dellon);
theta(dellon<0)=theta(dellon<0)+pi;

if plotornot
    % plot magnitude
    [dive,surface]=indexsplit(t);
    f1=figure
    subplot(2,1,1)
    hist(mag(dive(2:end)));
    title(strcat('Magnitude of Sub-Surface Velocity of',{' '},name));
    xlabel('m/s');
    ylabel('Frequency');
    subplot(2,1,2)
    hist(mag(surface));
    title(strcat('Magnitude of Surface Velocity of',{' '},name));
    xlabel('m/s');
    ylabel('Frequency');

    % plot theta
    f2=figure
    subplot(1,2,1)
    rose(theta(dive(2:end)));
    title(strcat('Direction of Sub-Surface Drift of',{' '},name));
    subplot(1,2,2)
    rose(theta(surface));
    title(strcat('Direction of Surface Drift of',{' '},name));
end

% Optional output
varns={mag,theta};
varargout=varns(1:nargout);

