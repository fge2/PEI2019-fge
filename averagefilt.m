function varargout=averagefilt(record)
% avg24=averagefilt(record)
%
% This function applys a 1 hour moving average to a vector
%
% INPUT:
% 
% record            data to be filtered
%
% OUTPUT:
%
% avg24             filtered averaged data
%
% last modified by fge@princeton.edu on 7/30/19

hoursPerDay = 24;
type='temp';
switch type
    case 'seismic'
        samplesperfile=360000;
        desamplerate=25;
        samplesperhour=samplesperfile/desamplerate;
    case 'temp'
        samplesperhour=60;
end
coeff24hMA = ones(1, hoursPerDay*samplesperhour)/(hoursPerDay*samplesperhour);

% filter twice
temp = filter(coeff24hMA, 1, record);
avg24 = flip(filter(coeff24hMA, 1, flip(temp)));

Dt=datetime('1-Jan-2018')+start-1;
time=seconds(t)+Dt;
figure
plot(time,[record avg24])
legend('Temperature','24 Hour Average','location','best')
ylabel('Temperature (deg C)')
xlabel('Date')
title('Temperaure Measured by Guyot Weather Station')
avg24 = filter(coeff24hMA, 1, record);
plot(days,[avg24])
ylabel('')
xlabel('')
title('')

% Optional output
varns={avg24};
varargout=varns(1:nargout);

