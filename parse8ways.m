function varargout=parse8ways(data)
% [time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(data)
% 
% This function parses weather data from a split string vector
%
% INPUT:
%
% data      The data from ascreadin
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

% split
time=data(:,1);
Dm=data(:,2);
Sm=data(:,3);
Ta=data(:,4);
Ua=data(:,5);
Pa=data(:,6);
Rc=data(:,7);
Hc=data(:,8);

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);

