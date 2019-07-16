function varargout=filtertest(filename,order,Wn)
% [xfilt,f]=filtertest(filename,order,Wn)
%
% This function plots the SeisData and a given bandpass filter using butter
% and the filtered data
%
% INPUT:
%
% filename      The filename including path
% order         The order of the butter filter
% Wn            The cutoff frequencies of the filter
%
% OUTPUT:
%
% f             The figure handle to the plot
%
% last modified by fge@princeton.edu on 7/9/2019

[SeisData,HdrData,tnu,pobj,tims]=readsac(filename,0,'l');

f=figure;
subplot(221)
S=detrend(SeisData);
plotsac(S,HdrData);

subplot(222)
smag=abs(fft(S));
n=length(smag);
plot(0:2/n:1-2/n,smag(1:n/2));
xlabel('Normalized Frequency (pi rad/samples)');
ylabel('Magnitude');

subplot(223)
[B,A]=butter(order,Wn,'bandpass');
plot(0:2/n:1-2/n,abs(freqz(B,A,n/2)))
xlabel('Normalized Frequency (pi rad/samples)');
ylabel('Magnitude');

subplot(224)
xfilt=filter(B,A,S);
plotsac(xfilt,HdrData);

% Optional output
varns={xfilt,f};
varargout=varns(1:nargout);

