function varargout=weatherplt(year,start,length)
% 
%
% This function plots the weather data
%
% INPUT:
%
% year
% number
% 
% OUTPUT:
%
%
% last modified by fge@princeton.edu on 7/2/2019

[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readweek(year,start);
time=time./3600;
subplot(4,2,1)
plot(time,Dm);
subplot(4,2,2);
plot(time,Sm);
subplot(4,2,3);
plot(time,Ta);
subplot(4,2,4);
plot(time,Ua);
subplot(4,2,5);
plot(time,Pa);
subplot(4,2,6);
plot(time,Rc);
subplot(4,2,7);
plot(time,Hc);

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);

