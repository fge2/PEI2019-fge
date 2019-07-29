function varargout=averagefilt(record)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

hoursPerDay = 24;
type='temp';
switch type
    case 'seismic'
        samplesperhour=360000;
    case 'temp'
        samplesperhour=60;
end
coeff24hMA = ones(1, hoursPerDay*samplesperhour)/(hoursPerDay*samplesperhour);

avg24 = filter(coeff24hMA, 1, record);
plot(days,[avg24])
ylabel('')
xlabel('')
title('')

% Optional output
varns={avg24};
varargout=varns(1:nargout);

