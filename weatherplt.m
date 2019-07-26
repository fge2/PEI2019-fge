function varargout=weatherplt(year)
% f=weatherplt(year)
%
% This function plots the weather data
%
% INPUT:
%
% year       The year of data to be analyzed
% 
% OUTPUT:
%
% f          The fourier coefficients resulting from polyfit on Ta
%
% last modified by fge@princeton.edu on 7/2/2019


[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readall(year);
timeday=time./(24*3600);

figure
subplot(4,2,1)
plot(timeday,Dm);
xlabel('time (days)')
ylabel('Dm')
subplot(4,2,2);
plot(timeday,Sm);
xlabel('time (days)')
ylabel('Sm')
subplot(4,2,3);
plot(timeday,Ta);
xlabel('time (days)')
ylabel('Ta')
subplot(4,2,4);
plot(timeday,Ua);
xlabel('time (days)')
ylabel('Ua')
subplot(4,2,5);
plot(timeday,Pa);
xlabel('time (days)')
ylabel('Pa')
subplot(4,2,6);
plot(timeday,Rc);
xlabel('time (days)')
ylabel('Rc')
subplot(4,2,7);
plot(timeday,Hc);
xlabel('time (days)')
ylabel('Hc')

input=1;
switch input
    case 1
        f=fit(time(:),Ta(:),'fourier8')
        figure
        plot(f,time,Ta,'-')
        title('Fourier Fit for Temperature');
        xlabel('time (days)');
        ylabel('Ta');
    case 2
        length(Ta)
        y=abs(fft(Ta));
        figure
        plot(y);
        xlim([-100000 600000]);
        w=525562/(24*3600);
        A=ones(length(timeday),3);
        A(:,2)=cos(w*timeday);
        A(:,3)=sin(w*timeday);
        x=(A'*A)\(A'*Ta)
end
f=[];

% Optional output
varns={f};
varargout=varns(1:nargout);

