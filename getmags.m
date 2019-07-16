function varargout=getmags(minmag)
% mags=getmags(minmag)
%
% This function returns the magnitudes of all earthquakes above a threshold
% given by irisFetch
%
% INPUT:
%
% minmag         minimum threshold to return
% start          start time 'YYYY-MM-DD HH:MM:SS'
% end            end time
%
% OUTPUT:
%
% mags           Magnitudes of the earthquakes
%
% Last modified by fge@princeton.edu on 7/16/19


ev = irisFetch.Events('starttime','2019-07-01','endtime','2019-07-08','minimummagnitude',minmag);
mags=[ev.PreferredMagnitudeValue];

% Optional output
varns={mags};
varargout=varns(1:nargout);


