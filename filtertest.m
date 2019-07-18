function varargout=filtertest(filename,order,Wn,type)
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
% type          Low,High,etc
%
% OUTPUT:
%
% f             The figure handle to the plot
%
% last modified by fge@princeton.edu on 7/9/2019

defval('type','low');
[SeisData,HdrData,tnu,pobj,tims]=readsac(filename,0,'l');

S=detrend(SeisData);
smag=abs(fft(S));
sangle=angle(fft(S));
n=length(smag);
[B,A]=butter(order,Wn,type);
xfilt=filter(B,A,S);
xfilt=flip(filter(B,A,flip(xfilt)));

f=figure;
subplot(211)
plotsac(S,HdrData);
subplot(212)
plotsac(xfilt,HdrData);

%plotornot
plot=0;
if plot
    figure
    subplot(211)
    plot(0:2/n:1-2/n,smag(1:floor(n/2)));
    title('Magnitude of Signal')
    xlabel('Normalized Frequency (pi rad/samples)');
    ylabel('Magnitude');
    subplot(212)
    plot(0:2/n:1-2/n,sangle(1:floor(n/2)));
    title('Phase Response of Signal')
    xlabel('Normalized Frequency (pi rad/samples)');
    ylabel('Phase');

    figure
    subplot(211)
    plot(0:2/n:1-2/n,abs(freqz(B,A,floor(n/2))))
    title('Magnitude Gain Response')
    xlabel('Normalized Frequency (pi rad/samples)');
    ylabel('Magnitude');
    subplot(212)
    plot(0:2/n:1-2/n,angle(freqz(B,A,floor(n/2))))
    title('Phase Response')
    xlabel('Normalized Frequency (pi rad/samples)');
    ylabel('Phase');
end

% Optional output
varns={xfilt,f};
varargout=varns(1:nargout);

