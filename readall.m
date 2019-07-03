function varargout=readall(year)
% [time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=readall(year)
%
% This function reads any timeframe 
%
% INPUT:
%
%
%
% OUTPUT:
%
%
%
% last modified by fge@princeton.edu on 7/2/19

files=dir(strcat('/home/fge/PTONcGPS/WeatherData/',year,'/*.asc'));
data=[];
for i=2:length(files)
    filename=files(i).name;
    output=cell2mat(textscan(fopen(strcat('/home/fge/PTONcGPS/WeatherData/'...
        ,year,'/',filename)),'%f %f %f %f %f %f %f %f'));
    data=[data; output];
end
[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(data);

z=find(time==0);
z=flip(z);

for j = z'
    if j > 1
        time(j:end)=time(j:end)+time(j-1);
    end
end
time=time-time(1);

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);

