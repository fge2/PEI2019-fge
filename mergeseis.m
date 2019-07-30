function varargout=mergeseis(YYYY,MM,DD,indexno)
% finalseis=mergeseis(YYYY,MM,DD,indexno)
%
% This function merges a day of seismic data together
%
% INPUT:
%
% YYYY        year string
% MM          month string
% DD          day string
% indexno     day of year
%
% OUTPUT:
% 
% finalseis   vector of seismic data for the entire day
%
% last modified by fge@princeton.edu on 7/30/19

sampleperfile=360000;
downsamplerate=25;
finalseis=zeros(sampleperfile*24,1);
prefix=strcat('/home/fge/seismometer/all',YYYY,'/');
for i=0:23
    filename=strcat(prefix,'PP.S0001.00.HHX.D.',YYYY,'.',num2str(indexno),'.',sprintf('%02d',i),'0000.SAC');
    if exist(filename,'file')==0
        seis=NaN(sampleperfile,1);
    else
        seis=readsac(filename);
    end
    if length(seis)~=sampleperfile
        temp=seis;
        seis=NaN(sampleperfile,1);
        seis(1:length(temp))=temp;
    end
    seis=decimate(seis,downsamplerate);
    finalseis(i*sampleperfile+1:(i+1)*sampleperfile)=seis;
end

plot=0;
if plot
    startdate=datetime(strcat(MM,'/',DD,'/',YYYY),'InputFormat','MM/dd/yyyy');
    t=seconds(0:(length(finalseis)-1))/100 + startdate;
    plot(t,detrend(finalseis));
    xlim([t(1) t(end)])
    title(strcat('Guyot Seismogram',{' '},MM,'/',DD,'/',YYYY))
    xlabel('Hour')
end 

% Optional output
varns={finalseis};
varargout=varns(1:nargout);