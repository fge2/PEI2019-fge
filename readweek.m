function varargout=readweek(year,start)
% [time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readweek(year,number)
% 
% This function parses weather data from a week of .asc files
%
% INPUT:
%
% year
% start
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
    strcombine=strings;
    for i=0:6
        strcombine=cell2mat(strcat(strcombine,{newline},ascreadin(year,start+i)));
    end
    [time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(strcombine(2:end));
end

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);