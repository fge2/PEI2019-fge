function varargout=readibtracs(table)
% [name,index,isotime,lat,lon,wind,pres,speed,dir]=readibtracs(table)

load(table);
name=ibtracs.NAME(2:end);
isotime=ibtracs.ISO_TIME(2:end);
lat=ibtracs.LAT(2:end);
lon=ibtracs.LON(2:end);
wind=ibtracs.WMO_WIND(2:end);
pres=ibtracs.WMO_PRES(2:end);
speed=ibtracs.STORM_SPEED(2:end);
dir=ibtracs.STORM_DIR(2:end);
i=1:length(name)-1;
index=[1; find(name(i)~=name(i+1))+1];

% Optional output
varns={name,index,isotime,lat,lon,wind,pres,speed,dir};
varargout=varns(1:nargout);
