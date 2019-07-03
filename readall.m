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
strcombine=strings;
for i=1:length(files)
    a=fileread(strcat('/home/fge/PTONcGPS/WeatherData/',num2str(year),'/',files(i).name));
    strcombine=strcat(strcombine,{newline},a);
end
strcombine=cell2mat(strcombine);
[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(strcombine(2:end));

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

