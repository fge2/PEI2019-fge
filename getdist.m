function varargout=getdist(start,endtime,minmag)
% dists=getmags(start,endtime,minmag)
%
% This function returns the distances to Guyot Hall of all earthquakes 
% above a threshold given by irisFetch
%
% INPUT:
%
% minmag         minimum threshold to return
% start          start time 'YYYY-MM-DD HH:MM:SS'
% endtime        end time
%
% OUTPUT:
%
% dists          distances to GuyotPhysics seismometer
%
% Last modified by fge@princeton.edu on 7/16/19

defval('start','2019-07-01');
defval('endtime','2019-07-08');
defval('minmag',5);
% Guyot coords
Guyotlat=40.35;
Guyotlon=-74.65;

ev = irisFetch.Events('starttime',start,'endtime',endtime,'minimummagnitude',minmag);
lats=[ev.PreferredLatitude];
lons=[ev.PreferredLongitude];
dists=(distance(lats,lons,Guyotlat,Guyotlon));

% Optional output
varns={dists};
varargout=varns(1:nargout);

