function varargout=readany(year,start,length)
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

listlength=10080;

files=dir('/home/fge/PTONcGPS/WeatherData/2018/*.asc')
strcombine='';
for file=files
    a=fileread(file);
    a=extractAfter(a,'--------------------------------------- ');
    strcombine=strcat(strcombine,a);
end
[time,Dm,Sm,Ta,Ua,Pa,Rc,Hc]=parse8ways(strcombine);

z=find(time==0);
z=flip(z);
for i=z
    time(z:end)=time(z:end)+time(z-1);
end

% Optional output
varns={time,Dm,Sm,Ta,Ua,Pa,Rc,Hc};
varargout=varns(1:nargout);

