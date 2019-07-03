function varargout=readall(year)
% varargout=readany(year,start,length)
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

files=dir(strcat('/home/fge/PTONcGPS/WeatherData/',num2str(year),'/*.asc'));
strcombine='';
for file=files
    a=fileread(file);
    strcombine=strcat(strcombine,a);
end
[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(strcombine);

z=find(time==0);
z=flip(z);
for i=z
    if i > 1
        time(i:end)=time(i:end)+time(i-1);
    end
end
time=time-time(1);

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);

