function varargout=mergeseis(YYYY,MM,DD,indexno)
%

finalseis=zeros();
%prefix=strcat('/home/fge/seismometer/',YYYY,'/',MM,'/',DD,'/');
prefix=strcat('/home/fge/seismometer/allseis/');
for i=0:23
    seis=readsac(strcat(prefix,'PP.S0001.00.HHX.D.',YYYY,'.',num2str(indexno),'.',sprintf('%02d',i),'0000.SAC'));
    finalseis=[finalseis; seis];
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