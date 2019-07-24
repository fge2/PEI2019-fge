function varargout=filterfit(seisfilt)
% f=filtertest(seisfilt)
%
% This function fits the seisdata to a fourier series using fit 
%
% INPUT:
%
% seisfilt      Filtered seismic data vector
%
% OUTPUT:
%
% 
%
% last modified by fge@princeton.edu on 7/23/2019

time=(1:360000)';
%time=time(189000:200000);
%seisfilt=seisfilt(189000:200000);
f=fit(time,seisfilt,'fourier4');
figure
plot(f,time,seisfilt,'-');
xlim([0 360000])
title('Filtered Seismogram Fit')
xlabel('time (seconds)')
ylabel('')

% Optional output
varns={f};
varargout=varns(1:nargout);

