function varargout=readibtracs(table)
% [name,index,isotime,lat,lon,wind,pres,speed,dir]=readibtracs(table)
%
% This function reads in ibtracs tables after formatting
%
% INPUT:
% 
% table               ibtracs table in matlab
%
% OUTPUT:
%
% name                name of hurricanes
% index               indices of data
% lat                 lat vector
% lon                 lon vector
% isotime             time vector
% wind                wind speed vector
% pres                pressure vector
% speed               hurricane speed vector
% dir                 direction vector
%
% last modified by fge@princeton.edu on 7/30/19

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
