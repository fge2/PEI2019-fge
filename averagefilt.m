function varargout=averagefilt(record,doy)
% avg24=averagefilt(record)
%
% This function applys a 1 hour moving average to a vector
%
% INPUT:
% 
% record            data to be filtered
% doy               day of year
%
% OUTPUT:
%
% avg24             filtered averaged data
%
% last modified by fge@princeton.edu on 7/30/19

Dt=datetime('1-Jan-2018')+doy-1;
hoursPerDay = 24;
type='temp';
switch type
    case 'seismic'
        samplesperfile=360000;
        desamplerate=25;
        samplesperhour=samplesperfile/desamplerate;
        t=(0:length(record)-1)/(100/desamplerate);
        time=seconds(t)+Dt;
    case 'temp'
        samplesperhour=60;
        t=(0:length(record)-1);
        time=minutes(t)+Dt;
end
coeff24hMA = ones(1, hoursPerDay*samplesperhour)/(hoursPerDay*samplesperhour);

% filter twice
temp = filter(coeff24hMA, 1, record);
avg24 = flip(filter(coeff24hMA, 1, flip(temp)));

figure
plot(time,[record avg24])
legend('Temperature','24 Hour Average','location','best')
ylabel('Temperature (deg C)')
xlabel('Date')
title('Temperaure Measured by Guyot Weather Station')

% Optional output
varns={avg24};
varargout=varns(1:nargout);

