function varargout=findrecord(minmag)
% []=findrecord(minmag)
%
% This function returns nearest records of earthquakes above a certain
% threshold
%
% INPUT:
%
% minmag         minimum threshold to return
% start          start time 'YYYY-MM-DD HH:MM:SS'
% end            end time
%
% OUTPUT:
%
% 
%
% Last modified by fge@princeton.edu on 7/16/19

ev = irisFetch.Events('starttime','2019-07-01','endtime','2019-07-08','minimummagnitude',minmag);
times=extractfield(ev,'PreferredTime');
times=datetime(datevec(times));
Day=day(times);
Hour=hour(times);
Minute=minute(times);
xfiles=string(strcat('PP.S0001.00.HHX.D.2019.18',num2str(Day),'.',num2str(Hour),'0000.SAC'));
yfiles=string(strcat('PP.S0001.00.HHY.D.2019.18',num2str(Day),'.',num2str(Hour),'0000.SAC'));
zfiles=string(strcat('PP.S0001.00.HHZ.D.2019.18',num2str(Day),'.',num2str(Hour),'0000.SAC'));

% Optional output
varns={};
varargout=varns(1:nargout);