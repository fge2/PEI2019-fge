function varargout=positionplt(float_name)
% f=positionplt(float_name)
% 
% Plots mermaid data on latlon scale
%
% INPUT:
%  
% float_name  The name of the mermaid float
%
% OUTPUT:
%
% f           The figure handle
%
% Last modified by fge@princeton.edu on 6/28/19

defval('float_name','P017');
defval('latlim',[-12 -10.5]);
defval('lonlim',[-138 -135.5]);

[name,t,lat,lon]=mread(float_name);
n=length(t);
latlim=[floor(2*min(lat))/2,ceil(2*max(lat))/2];
lonlim=[floor(2*min(lon))/2,ceil(2*max(lon))/2];

% Plot coordinates
f = figure;
worldmap(latlim, lonlim);
geoshow(lat,lon,'DisplayType','Point','Marker','o','MarkerFaceColor','red','Markersize',5);
handle=title(strcat('Path of',{' '},name));
%p=handle.Position
%handle.Position=[p(1) p(2)+0.02e+06 p(3)];
xlabel('Latitude');
ylabel('Longitude');

% Surfacing dates
[dive,surface]=indexsplit(t);
textm(lat(dive),lon(dive)+0.02,datestr(t(dive),'mm-dd-yy'));

% Plot displacement
dellat=lat(2:n)-lat(1:n-1);
dellon=lon(2:n)-lon(1:n-1);
i=dive(2:end)-1;
j=surface-1;
d = quiverm(lat(i),lon(i),dellat(i),dellon(i));
s = quiverm(lat(j),lon(j),dellat(j),dellon(j),'m');
legend([d(1);s(1)],'Underwater Displacement Vectors',...
    'Surface Level Displacement Vectors','Location','southeast')
hold off

% Optional output
varns={f};
varargout=varns(1:nargout);
