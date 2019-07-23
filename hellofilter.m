clf
clear all

w1=1/4;
w2=1;
w3=4;
w4=16;
Fs=100;
t=0:1/Fs:1-1/Fs;
n=length(t);
z=                              cos(2*pi*w3*t);
x=cos(2*pi*w1*t)+cos(2*pi*w2*t)+cos(2*pi*w3*t)+cos(2*pi*w4*t);

ah(1)=subplot(321);
plot(t,x);
title('Cos signal')
xlabel('t')
ylabel('x(t)')

axis=0:2/n:1-2/n;
axis=axis*Fs/2;

ah(2)=subplot(322);
mag=abs(fft(x));
stem(axis,mag(1:length(mag)/2).^2)
title('Magnitude of Fourier Transform')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

ah(3)=subplot(323);
[B,A]=butter(2,[.05 .15],'bandpass');
[H,W]=freqz(B,A,n/2);
plot(axis,abs(H),'r')
title('Filter Gain Magnitude Response')
xlabel('Frequency (Hz)')
ylabel('Magnitude')

ah(4)=subplot(324);
plot(axis,angle(H),'r')
title('Filter Phase Response')
xlabel('Frequency (Hz)')
ylabel('Phase')

ah(5)=subplot(325);
xfilt=filter(B,A,x);
plot(t,xfilt,'r')
title('1 Pass Filtered')
xlabel('t')
ylabel('x(t)')

ah(6)=subplot(326);
xfilt2=flipud(filter(B,A,flipud(xfilt(:))));
plot(t,xfilt2,'r')
title('2 Pass Filtered')
xlabel('t')
ylabel('x(t)')

axes(ah(2))
hold on
mag=abs(fft(xfilt2));
stem(axis,mag(1:length(mag)/2).^2)
hold off

axes(ah(5))
hold on
plot(t,z);

axes(ah(6))
hold on
plot(t,z);

% Cosmetics
set(ah([2 3 4]),'xtick',[w1 w2 w3 w4])


