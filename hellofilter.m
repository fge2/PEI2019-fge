w1=1/4;
w2=1;
w3=4;
w4=16;
Fs=100;
t=0:1/Fs:1-1/Fs;
n=length(t);
%x=cos(8*pi*t);
x=cos(2*pi*w1*t)+cos(2*pi*w2*t)+cos(2*pi*w3*t)+cos(2*pi*w4*t);

subplot(321)
plot(t,x);
title('Cos signal')
xlabel('t')
ylabel('x(t)')
subplot(322)
mag=abs(fft(x));
plot(0:2/n:1-2/n,mag(1:length(mag)/2))
title('Fourier Transform')
xlabel('Frequency (pi rad/samples)')
ylabel('Magnitude')
subplot(323)
[B,A]=butter(2,[.05 .15],'bandpass');
[H,W]=freqz(B,A,n/2);
plot(0:2/n:1-2/n,abs(H),'r')
title('Filter Gain Magnitude Response')
xlabel('Frequency (pi rad/samples)')
ylabel('Magnitude')
subplot(324)
plot(0:2/n:1-2/n,angle(H),'c')
title('Filter Phase Response')
xlabel('Frequency (pi rad/samples)')
ylabel('Phase')
subplot(325)
xfilt=filter(B,A,x);
plot(t,xfilt)
title('1 Pass Filtered')
xlabel('t')
ylabel('x(t)')
subplot(326)
xfilt2=flipud(filter(B,A,flipud(xfilt(:))));
plot(t,xfilt2)
title('2 Pass Filtered')
xlabel('t')
ylabel('x(t)')

