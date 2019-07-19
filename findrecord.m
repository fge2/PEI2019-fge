function varargout=findrecord(minmag)
% [xfiles,yfiles,zfiles,times,pID]=findrecord(minmag)
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
% xfiles         xfiles of local seismometers at approximate time of
%                earthquake
% yfiles         yfiles
% zfiles         zfiles
% times          datetime vec fo earthquake events
% pID            public ID
%
% Last modified by fge@princeton.edu on 7/16/19

ev = irisFetch.Events('starttime','2019-07-01','endtime','2019-07-08','minimummagnitude',minmag);
pID=extractfield(ev,PubkicID);
times=extractfield(ev,'PreferredTime');
times=datetime(datevec(times));
Day=day(times);
Hour=hour(times);
Minute=minute(times);
%%%%%%%%%%%
index=find(Minute-1>=55);
Hour(index)=Hour(index)+1;
%%%%%%%%%%%
Hourstr=strings(length(Hour),1);
for i=1:length(Hour)
    Hourstr(i)=sprintf('%02d',Hour(i));
end
xfiles=char(strcat('PP.S0001.00.HHX.D.2019.18',num2str(Day+1),'.',Hourstr,'0000.SAC'));
yfiles=char(strcat('PP.S0001.00.HHY.D.2019.18',num2str(Day+1),'.',Hourstr,'0000.SAC'));
zfiles=char(strcat('PP.S0001.00.HHZ.D.2019.18',num2str(Day+1),'.',Hourstr,'0000.SAC'));

% Optional output
varns={xfiles,yfiles,zfiles,times,pID};
varargout=varns(1:nargout);