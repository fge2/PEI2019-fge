function varargout=filterfit(seisfilt)
% []=filtertest(seisfilt)
%
% This function plots the SeisData and a given bandpass filter using butter
% and the filtered data
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

time=1:3600;
f=fit(time,seisfilt,'fourier2');
figure
plot(f,time,seisfilt);
title('Filtered Seismogram Fit')
xlabel('time (seconds)')
ylabel('')

% Optional output
varns={xfilt,HdrData};
varargout=varns(1:nargout);

