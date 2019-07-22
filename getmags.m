function varargout=getmags(start,endtime,minmag)
% mags=getmags(start,end,minmag)
%
% This function returns the magnitudes of all earthquakes above a threshold
% given by irisFetch
%
% INPUT:
%
% minmag         minimum threshold to return
% start          start time 'YYYY-MM-DD HH:MM:SS'
% endtime        end time
%
% OUTPUT:
%
% mags           Magnitudes of the earthquakes
%
% Last modified by fge@princeton.edu on 7/16/19

defval('start','2019-07-01');
defval('endtime','2019-07-08');
defval('minmag',5);

ev = irisFetch.Events('starttime',start,'endtime',endtime,'minimummagnitude',minmag);
mags=[ev.PreferredMagnitudeValue];

% Optional output
varns={mags};
varargout=varns(1:nargout);


