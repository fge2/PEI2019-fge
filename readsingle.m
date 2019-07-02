function varargout=readsingle(year,number)
% [time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readsingle(year,number)
% 
% This function parses weather data from a single .asc file
%
% INPUT:
%
% year
% number
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

datastr=strcat('',ascreadin(year,number));
[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(datastr);

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);
