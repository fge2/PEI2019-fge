function varargout=positionplt(float_name,latlim,lonlim)
% f=positionplt(latlim,lonlim)
% 
% Plots mermaid data on latlon scale
%
% INPUT:
%  
% float_name  The name of the mermaid float
% latlim      The latitude limits given in a 1x2 vector
% lonlim      The longitude limits given in 1x2 vector
%
% OUTPUT:
%
% f           The figure handle
%
% Last modified by fge@princeton.edu on 6/26/19

defval('float_name','P017');
defval('latlim',[-12 -10.5]);
defval('lonlim',[-138 -135.5]);
[name,t,lat,lon]=mread(float_name);
n=length(t);

% Plot coordinates
f = figure;
worldmap(latlim, lonlim);
geoshow(lat,lon,'DisplayType','Point','Marker','o','MarkerFaceColor','red','Markersize',5);
handle=title(strcat('Path of',{' '},name));
handle.Position=[0.1746 -1.127e+06 -2.1102e-16];
xlabel('Latitude');
ylabel('Longitude');

% Surfacing dates
[dive,surface]=indexsplit(t);
textm(lat(dive),lon(dive)+0.02,datestr(t(dive),'mm-dd-yy'));
textm(lat(59),lon(59)+.02,datestr(t(59),'mm-dd-yy'));

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
