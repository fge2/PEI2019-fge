function varargout=filterfit(seisfilt,Hdr)
% f=filtertest(seisfilt)
%
% This function plots the SeisData and a given bandpass filter using butter
% and the filtered data
%
% INPUT:
%
% seisfilt      Filtered seismic data vector
% Hdr           Headerdata
%
% OUTPUT:
%
% 
%
% last modified by fge@princeton.edu on 7/23/2019

time=(1:360000)';
f=fit(time,seisfilt,'fourier8');
plotsac(seisfilt,Hdr)
hold on
plot(f,time,seisfilt);
title('Filtered Seismogram Fit')
xlabel('time (seconds)')
ylabel('')

% Optional output
varns={f};
varargout=varns(1:nargout);

