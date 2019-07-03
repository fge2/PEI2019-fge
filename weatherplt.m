function varargout=weatherplt(year)
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


[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readall(year);
time=time./(24*3600);

figure
subplot(4,2,1)
plot(time,Dm);
xlabel('time (days)')
ylabel('Dm')
subplot(4,2,2);
plot(time,Sm);
xlabel('time (days)')
ylabel('Sm')
subplot(4,2,3);
plot(time,Ta);
xlabel('time (days)')
ylabel('Ta')
subplot(4,2,4);
plot(time,Ua);
xlabel('time (days)')
ylabel('Ua')
subplot(4,2,5);
plot(time,Pa);
xlabel('time (days)')
ylabel('Pa')
subplot(4,2,6);
plot(time,Rc);
xlabel('time (days)')
ylabel('Rc')
subplot(4,2,7);
plot(time,Hc);
xlabel('time (days)')
ylabel('Hc')


f=fit(time(:),Ta(:),'fourier2');
figure
plot(f,time,Ta)
title('Fourier Fit for Temperature');
xlabel('time (days)');
ylabel('Ta');


% Optional output
varns={f};
varargout=varns(1:nargout);

