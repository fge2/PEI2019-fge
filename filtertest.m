function varargout=filtertest(filename,SeisData,order,Wn,type,plotornot)
% [xfilt,f]=filtertest(filename,SeisData,order,Wn,type,plotornot)
%
% This function plots the SeisData and a given bandpass filter using butter
% and the filtered data
%
% INPUT:
%
% filename      The filename including path
% Seisdata      The data vector if we are giving it the vector directly
% order         The order of the butter filter
% Wn            The cutoff frequencies of the filter
% type          Low,High,etc
% plotornot
%
% OUTPUT:
%
% xfilt         Filtered data vector
% HdrData       Headerdata
% f             The figure handle to the plot
%
% last modified by fge@princeton.edu on 7/9/2019

defval('type','low');
Fs=50;

if filename~=[]
    [SeisData,HdrData,tnu,pobj,tims]=readsac(filename,0,'l');
end
HdrData=[];

Wn=Wn*(2/Fs);
S=detrend(SeisData);
smag=abs(fft(S));
sangle=angle(fft(S));
n=length(smag);
[B,A]=butter(order,Wn,type);
xfilt=filter(B,A,S);
xfilt=flip(filter(B,A,flip(xfilt)));

%plotornot
defval('plotornot',0);
if plotornot
    f=figure;
    subplot(211)
    plotsac(S,HdrData);
    subplot(212)
    plotsac(xfilt,HdrData);
    max(xfilt);

    axes=(0:2/n:1-2/n)*Fs/2;
    figure
    subplot(211)
    plot(axes,smag(1:floor(n/2)));
    title('Magnitude of Signal')
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    subplot(212)
    plot(axes,sangle(1:floor(n/2)));
    title('Phase Response of Signal')
    xlabel('Frequency (Hz)');
    ylabel('Phase');

    figure
    subplot(211)
    plot(0:2/n:1-2/n,abs(freqz(B,A,floor(n/2))))
    title('Magnitude Gain Response')
    xlabel('Frequency (Hz)');
    ylabel('Magnitude');
    subplot(212)
    plot(0:2/n:1-2/n,angle(freqz(B,A,floor(n/2))))
    title('Phase Response')
    xlabel('Frequency (Hz)');
    ylabel('Phase');
end

% Optional output
varns={xfilt,HdrData};
varargout=varns(1:nargout);

