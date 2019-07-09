function varargout=readsingle(year,number)
% [time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readsingle(year,number)
% 
% This function parses weather data from a single .asc file
%
% INPUT:
%
% year         year of data to be analyzed
% number       the file number
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

[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(ascreadin(year,number));

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);
