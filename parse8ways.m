function varargout=parse8ways(datastr)
% [time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(datastr)
% 
% This function parses weather data from a split string vector
%
% INPUT:
%
% datastr      The data in string from outputted from fileread
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

datastr=strsplit(datastr);

% split
time=datastr(1:8:end);
Dm=datastr(2:8:end);
Sm=datastr(3:8:end);
Ta=datastr(4:8:end);
Ua=datastr(5:8:end);
Pa=datastr(6:8:end);
Rc=datastr(7:8:end);
Hc=datastr(8:8:end);

% cell2double
time=str2double(time);
Dm=str2double(Dm);
Sm=str2double(Sm);
Ta=str2double(Ta);
Ua=str2double(Ua);
Pa=str2double(Pa);
Rc=str2double(Rc);
Hc=str2double(Hc);

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);

