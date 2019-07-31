function varargout=mergeseisdays(year,startmonth,startday,indexno,days)
% merge=mergeseisdays(year,startmonth,startday,indexno,days)
%
% This function merges days of seismic data together
%
% INPUT:
%
% year             year string
% startmonth       month string
% startday         day string
% indexno          day of year
% days             number of days to merge
%
% OUTPUT:
% 
% merge            merged seis vector
% filt             filtered version
%
% last modified by fge@princeton.edu on 7/30/19

downsamplerate=25;
sampleperfile=360000/downsamplerate;
hoursperday=24;
startdate=datetime(strcat(startmonth,'/',startday,'/',year),'InputFormat','MM/dd/yyyy');
merge=zeros(days*sampleperfile*hoursperday,1);
for i=0:days-1
    seis=mergeseis(year,startmonth,startday,indexno);
    n=length(seis);
    merge(i*n+1:(i+1)*n)=seis;
    indexno=indexno+1;
end
figure
t=(0:(days*sampleperfile*downsamplerate*hoursperday)-1)/100;
t=decimate(t,downsamplerate);
t=seconds(t)+startdate;
Wn=[0.03 0.06];
filt=filtertest([],merge,2,Wn,'bandpass',0);
plot(t,filt)
%plot(t,merge);
xlim([t(1) t(end)])
title(strcat('Guyot Seismogram'))

% Optional output
varns={merge,filt};
varargout=varns(1:nargout);
    

