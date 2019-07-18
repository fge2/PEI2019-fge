function varargout=getdist(minmag)
% dists=getmags(minmag)
%
% This function returns the distances to Guyot Hall of all earthquakes 
% above a threshold given by irisFetch
%
% INPUT:
%
% minmag         minimum threshold to return
% start          start time 'YYYY-MM-DD HH:MM:SS'
% end            end time
%
% OUTPUT:
%
% dists          distances to GuyotPhysics seismometer
%
% Last modified by fge@princeton.edu on 7/16/19

% Guyot coords
Guyotlat=40.35;
Guyotlon=-74.65;

ev = irisFetch.Events('starttime','2019-07-01','endtime','2019-07-08','minimummagnitude',minmag);
lats=[ev.PreferredLatitude];
lons=[ev.PreferredLongitude];
dists=(distance(lats,lons,Guyotlat,Guyotlon));

% Optional output
varns={dists};
varargout=varns(1:nargout);

