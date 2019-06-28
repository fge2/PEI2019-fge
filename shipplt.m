function varargout=shipplt()
% f=shipplt
% 
% Plots ship data on latlon scale
%
% INPUT:
%
% OUTPUT:
%
% f           The figure handle
%
% Last modified by fge@princeton.edu on 6/28/19

date_time = [{'05-Aug-2019 08:00:00'},{'06-Aug-2019 18:00:00'},{'07-Aug-2019 08:00:00'},...
    {'07-Aug-2019 23:00:00'},{'08-Aug-2019 13:00:00'}, {'09-Aug-2019 04:00:00'},...
    {'10-Aug-2019 08:00:00'}, {'11-Aug-2019 23:00:00'}, {'13-Aug-2019 01:00:00'},...
    {'14-Aug-2019 19:00:00'}, {'17-Aug-2019 01:00:00'}, {'18-Aug-2019 19:00:00'},...
    {'19-Aug-2019 08:00:00'}, {'20-Aug-2019 02:00:00'}, {'20-Aug-2019 20:00:00'},...
    {'21-Aug-2019 14:00:00'}, {'22-Aug-2019 13:00:00'}, {'23-Aug-2019 02:00:00'},...
    {'23-Aug-2019 15:00:00'}, {'24-Aug-2019 05:00:00'}, {'24-Aug-2019 19:00:00'},...
    {'25-Aug-2019 12:00:00'}, {'26-Aug-2019 04:00:00'}, {'26-Aug-2019 21:00:00'},...
    {'27-Aug-2019 14:00:00'}, {'30-Aug-2019 18:00:00'}, {'31-Aug-2019 08:00:00'}];
slon = [-149.3, -151.0, -150.0, -149.0, -148.0, -146.0, -144.0, -142.0, -135.0,...
    -136.0, -141.0, -149.0, -151.0, -154.0, -157.0, -160.0, -164.0, -166.0,...
    -168.0, -170.0, -172.0, -174.9, -177.6, -179.0, -180.0, -166.3, -166.3];
slat = [-17.3, -12.0, -10.0, -8.0, -6.0, -5.0, -6.0, -8.0, -13.0, -17.0, -22.0,...
    -27.0, -28.0, -29.0, -30.0, -31.0, -30.0, -29.0, -28.0, -27.0, -26.0, -25.65...
    -25.63, -25.0, -24.0, -22.2, -22.2];

n=length(date_time);
latlim=[floor(2*min(slat))/2,ceil(2*max(slat))/2 + 10];
lonlim=[floor(2*min(slon))/2,ceil(2*max(slon))/2];

% Plot coordinates
f = figure;
worldmap(latlim, lonlim);
geoshow(slat,slon,'DisplayType','Point','Marker','o','MarkerFaceColor','red','Markersize',5);
textm(slat,slon,datestr(date_time,'mm-dd-yy'));
title("Path of Ship");
xlabel('Longitude');
ylabel('Latitude');

% Plot displacement
dellat=slat(2:n)-slat(1:n-1);
dellon=slon(2:n)-slon(1:n-1);
hold on
q=quiverm(slat(1:n-1),slon(1:n-1),dellat,dellon);

% Optional output
varns={f};
varargout=varns(1:nargout);
