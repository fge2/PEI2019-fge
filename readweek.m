function varargout=readweek(year,start)
% [time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readweek(year,start)
% 
% This function parses weather data from a week of .asc files
%
% INPUT:
%
% year        The year to be analyzed
% start       The start file number that is a multiple of 7
% 
% OUTPUT:
%
% time
% Dm
% Sm
% Ta
% Ua
% Pa
% Rc 
% Hc
%
% last modified by fge@princeton.edu on 7/2/2019

if mod(start,7)==0
    data=[];
    for i=0:6
        data=[data; ascreadin(year,start+i)];
    end
    [time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(data);
end

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);